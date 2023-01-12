require 'spec_helper'

describe 'Categories Spec', type: :request do
  let!(:default_store) { base_category.store }
  let!(:base_category) { create(:base_category) }
  let!(:categories) { create_list(:category, 2, base_category: base_category, parent: base_category.root) }

  let(:store2)     { create(:store)}
  let!(:base_category2)  { create(:base_category, store: store2) }

  before { Aypex::Api::Config.api_v2_per_page_limit = 2 }
  after  { Aypex::Api::Config.api_v2_per_page_limit = 500}

  shared_examples 'returns valid category resource JSON' do
    it 'returns a valid category resource JSON response' do
      expect(response.status).to eq(200)

      expect(json_response['data']).to have_type('category')
      expect(json_response['data']).to have_relationships(:parent, :base_category, :children, :products, :image)
    end
  end

  describe 'categories#index' do
    context 'with no params' do
      let(:default_store_categories) { [base_category.root, categories].flatten }

      before { get '/api/v2/storefront/categories' }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns all categories' do
        expect(json_response['data'].size).to eq(3)
        expect(json_response['data'][0]).to have_type('category')
        expect(json_response['data'][0]).to have_relationships(:parent, :base_category, :children, :image)
        expect(json_response['data'][0]).not_to have_relationships(:produts)
      end

      it 'should return only default store categories' do
        expect(json_response['data'].map{ |t| t['id'] }).to match_array(default_store_categories.pluck(:id).map(&:to_s))
      end
    end

    context 'by roots' do
      before { get '/api/v2/storefront/categories?filter[roots]=true' }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns categories by roots' do
        expect(json_response['data'].size).to eq(1)
        expect(json_response['data'][0]).to have_type('category')
        expect(json_response['data'][0]).to have_id(base_category.root.id.to_s)
        expect(json_response['data'][0]).to have_relationship(:parent).with_data(nil)
        expect(json_response['data'][0]).to have_relationships(:parent, :base_category, :children, :image)
      end
    end

    context 'by parent' do
      before { get "/api/v2/storefront/categories?filter[parent_id]=#{base_category.root.id}" }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns children categories by parent' do
        expect(json_response['data'].size).to eq(2)
        expect(json_response['data'][0]).to have_relationship(:parent).with_data('id' => base_category.root.id.to_s, 'type' => 'category')
        expect(json_response['data'][1]).to have_relationship(:parent).with_data('id' => base_category.root.id.to_s, 'type' => 'category')
      end
    end

    context 'by parent permalink' do
      let!(:base_category_3) { create(:base_category, store: base_category.store) }
      let!(:category_3) { create(:category, base_category: base_category_3, parent: base_category_3.root) }

      before { get "/api/v2/storefront/categories?filter[parent_permalink]=#{base_category.root.permalink}" }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns children categories by parent' do
        expect(json_response['data'].size).to eq(2)
        expect(json_response['data'][0]).to have_relationship(:parent).with_data('id' => base_category.root.id.to_s, 'type' => 'category')
        expect(json_response['data'][1]).to have_relationship(:parent).with_data('id' => base_category.root.id.to_s, 'type' => 'category')
      end
    end

    context 'by base_category' do
      before { get "/api/v2/storefront/categories?base_category_id=#{base_category.id}" }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns categories by base_category' do
        expect(json_response['data'].size).to eq(3)
        expect(json_response['data'][0]).to have_relationship(:base_category).with_data('id' => base_category.id.to_s, 'type' => 'base_category')
        expect(json_response['data'][1]).to have_relationship(:base_category).with_data('id' => base_category.id.to_s, 'type' => 'base_category')
        expect(json_response['data'][2]).to have_relationship(:base_category).with_data('id' => base_category.id.to_s, 'type' => 'base_category')
      end
    end

    context 'by ids' do
      before { get "/api/v2/storefront/categories?filter[ids]=#{categories.map(&:id).join(',')}" }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns categories by ids' do
        expect(json_response['data'].size).to            eq(2)
        expect(json_response['data'].pluck(:id).sort).to eq(categories.map(&:id).map(&:to_s).sort)
      end
    end

    context 'by name' do
      before { get "/api/v2/storefront/categories?filter[name]=#{categories.last.name}" }

      it_behaves_like 'returns 200 HTTP status'

      it 'returns categoryx by name' do
        expect(json_response['data'].size).to eq(1)
        expect(json_response['data'].last['attributes']['name']).to eq(categories.last.name)
      end
    end

    context 'paginate categories' do
      context 'with specified pagination params' do
        context 'when per_page is between 1 and default value' do
          before { get '/api/v2/storefront/categories?page=1&per_page=1' }

          it_behaves_like 'returns 200 HTTP status'

          it 'returns specified amount of categories' do
            expect(json_response['data'].count).to eq 1
          end

          it 'returns proper meta data' do
            expect(json_response['meta']['count']).to eq 1
            expect(json_response['meta']['total_count']).not_to eq Aypex::Category.count
            expect(json_response['meta']['total_count']).to eq default_store.categories.count
          end

          it 'returns proper links data' do
            expect(json_response['links']['self']).to include('/api/v2/storefront/categories?page=1&per_page=1')
            expect(json_response['links']['next']).to include('/api/v2/storefront/categories?page=2&per_page=1')
            expect(json_response['links']['prev']).to include('/api/v2/storefront/categories?page=1&per_page=1')
          end
        end

        context 'when per_page is above the default value' do
          before { get '/api/v2/storefront/categories?page=1&per_page=10' }

          it 'returns the default number of categories' do
            expect(json_response['data'].count).to eq 3
          end
        end

        context 'when per_page is less than 0' do
          before { get '/api/v2/storefront/categories?page=1&per_page=-1' }

          it 'returns the default number of categories' do
            expect(json_response['data'].count).to eq 3
          end
        end

        context 'when per_page is equal 0' do
          before { get '/api/v2/storefront/categories?page=1&per_page=0' }

          it 'returns the default number of categories' do
            expect(json_response['data'].count).to eq 3
          end
        end
      end

      context 'without specified pagination params' do
        before { get '/api/v2/storefront/categories' }

        it_behaves_like 'returns 200 HTTP status'

        it 'returns specified amount of categories' do
          expect(json_response['data'].count).not_to eq Aypex::Category.count
          expect(json_response['data'].count).to eq default_store.categories.count
        end

        it 'returns proper meta data' do
          expect(json_response['meta']['count']).to       eq json_response['data'].count
          expect(json_response['meta']['total_count']).not_to eq Aypex::Category.count
          expect(json_response['meta']['total_count']).to eq default_store.categories.count
        end

        it 'returns proper links data' do
          expect(json_response['links']['self']).to include('/api/v2/storefront/categories')
          expect(json_response['links']['next']).to include('/api/v2/storefront/categories?page=1')
          expect(json_response['links']['prev']).to include('/api/v2/storefront/categories?page=1')
        end
      end
    end
  end

  describe 'categories#show' do
    let(:category) { categories.first }

    context 'by id' do
      before do
        get "/api/v2/storefront/categories/#{category.id}"
      end

      it_behaves_like 'returns valid category resource JSON'

      it 'returns category by id' do
        expect(json_response['data']).to have_id(category.id.to_s)
        expect(json_response['data']).to have_attribute(:name).with_value(category.name)
      end
    end

    context 'by permalink' do
      before do
        get "/api/v2/storefront/categories/#{default_store.categories.first.permalink}"
      end

      it_behaves_like 'returns valid category resource JSON'

      it 'returns category by permalink' do
        expect(json_response['data']).to have_id(default_store.categories.first.id.to_s)
        expect(json_response['data']).to have_attribute(:name).with_value(default_store.categories.first.name)
      end
    end

    context 'with category image data' do
      shared_examples 'returns category image data' do
        it 'returns category image data' do
          expect(json_response['included'].count).to eq(1)
          expect(json_response['included'].first['type']).to eq('category_image')
        end
      end

      let!(:image) { create(:category_image, viewable: category) }
      let(:image_json_data) { json_response['included'].first['attributes'] }

      before { get "/api/v2/storefront/categories/#{category.id}?include=image#{category_image_transformation_params}" }

      context 'when no image transformation params are passed' do
        let(:category_image_transformation_params) { '' }

        it_behaves_like 'returns 200 HTTP status'
        it_behaves_like 'returns category image data'

        it 'returns category image' do
          expect(image_json_data['transformed_url']).to be_nil
        end
      end

      context 'when category image json returned' do
        let(:category_image_transformation_params) { '&category_image_transformation[size]=100x50&category_image_transformation[quality]=50' }

        it_behaves_like 'returns 200 HTTP status'
        it_behaves_like 'returns category image data'

        it 'returns category image' do
          expect(image_json_data['transformed_url']).not_to be_nil
        end
      end
    end
  end
end
