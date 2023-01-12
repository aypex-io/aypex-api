require 'spec_helper'

describe 'Platform API v2 Categories API' do
  include_context 'Platform API v2'

  let(:base_category) { create(:base_category, store: store) }
  let(:store_2) { create(:store) }
  let(:bearer_token) { { 'Authorization' => valid_authorization } }

  describe 'categories#index' do
    let!(:category) { create(:category, name: 'T-Shirts', base_category: base_category) }
    let!(:category_2) { create(:category, name: 'Pants', base_category: base_category) }
    let!(:category_3) { create(:category, name: 'T-Shirts', base_category: create(:base_category, store: store_2)) }

    context 'filtering' do
      before { get '/api/v2/platform/categories?filter[name_i_cont]=shirt', headers: bearer_token }

      it 'returns categories with matching name' do
        expect(json_response['data'].count).to eq 1
        expect(json_response['data'].first).to have_id(category.id.to_s)
        expect(json_response['data'].first).to have_relationships(:base_category, :parent, :children, :image)
      end
    end

    context 'sorting' do
      before { get '/api/v2/platform/categories?sort=name', headers: bearer_token }

      it 'returns categories sorted by name' do
        expect(json_response['data'].count).to eq base_category.categories.count
        expect(json_response['data'].first).to have_id(category_2.id.to_s)
      end
    end
  end

  describe 'categories#show' do
    let!(:category) { create(:category, name: 'T-Shirts', base_category: base_category) }

    context 'with valid id' do
      before { get "/api/v2/platform/categories/#{category.id}", headers: bearer_token }

      it 'returns category' do
        expect(json_response['data']).to have_id(category.id.to_s)
        expect(json_response['data']).to have_relationships(:base_category, :parent, :children, :image, :products)
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

      before { get "/api/v2/storefront/categories/#{category.id}?include=image#{category_image_transformation_params}", headers: bearer_token }

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

  shared_examples 'a resource containing metadata' do
    describe 'public metadata' do
      let(:metadata_params) { { public_metadata: public_metadata_params } }

      describe 'string entry' do
        let(:public_metadata_params) { { ability_to_recycle: '60%' } }

        it 'adds the metadata property' do
          expect(json_response['data']['attributes']['public_metadata']['ability_to_recycle']).to eq('60%')
        end
      end

      describe 'number entry' do
        let(:public_metadata_params) { { profitability: 3.4 } }

        it { expect(json_response['data']['attributes']['public_metadata']['profitability']).to eq('3.4') }
      end

      describe 'boolean entry' do
        let(:public_metadata_params) { { in_foreign_country: true } }

        it { expect(json_response['data']['attributes']['public_metadata']['in_foreign_country']).to eq('true') }
      end

      describe 'array entry' do
        let(:public_metadata_params) { { top_years: %w[2011 2016 2020] } }

        it { expect(json_response['data']['attributes']['public_metadata']['top_years']).to eq(%w[2011 2016 2020]) }
      end
    end

    describe 'private metadata' do
      let(:metadata_params) { { private_metadata: private_metadata_params } }

      describe 'string entry' do
        let(:private_metadata_params) { { ability_to_recycle: '60%' } }

        it { expect(json_response['data']['attributes']['private_metadata']['ability_to_recycle']).to eq('60%') }
      end

      describe 'number entry' do
        let(:private_metadata_params) { { profitability: 3.4 } }

        it { expect(json_response['data']['attributes']['private_metadata']['profitability']).to eq('3.4') }
      end

      describe 'boolean entry' do
        let(:private_metadata_params) { { in_foreign_country: false } }

        it { expect(json_response['data']['attributes']['private_metadata']['in_foreign_country']).to eq('false') }
      end

      describe 'array entry' do
        let(:private_metadata_params) { { top_years: %w[2011 2016 2020] } }

        it { expect(json_response['data']['attributes']['private_metadata']['top_years']).to eq(%w[2011 2016 2020]) }
      end
    end
  end

  describe 'categories#update for metadata' do
    let!(:category) { create(:category, name: 'T-Shirts', base_category: base_category) }

    before do
      patch "/api/v2/platform/categories/#{category.id}",
            headers: bearer_token,
            params: { category: metadata_params }
    end

    it_behaves_like 'a resource containing metadata'
  end

  describe 'categories#create for metadata' do
    before do
      post '/api/v2/platform/categories/',
           headers: bearer_token,
           params: {
             category: {
               name: 'Tires',
               base_category_id: base_category.id,
               parent_id: base_category.root.id
             }.merge(metadata_params)
           }
    end

    it_behaves_like 'a resource containing metadata'
  end

  describe 'categories#reposition' do
    let!(:category_a) { create(:category, name: 'T-Shirts', base_category: base_category) }
    let!(:category_b) { create(:category, name: 'Shorts', base_category: base_category) }
    let!(:category_c) { create(:category, name: 'Pants', base_category: base_category) }

    context 'with no params' do
      let(:params) do
        {
          category: {
            new_parent_id: nil,
            new_position_idx: nil
          }
        }
      end

      before do
        patch "/api/v2/platform/categories/#{category_a.id}/reposition", headers: bearer_token, params: params
      end

      it_behaves_like 'returns 404 HTTP status'
    end

    context 'with none existing parent ID' do
      let(:params) do
        {
          category: {
            new_parent_id: 999129192192,
            new_position_idx: 0
          }
        }
      end

      before do
        patch "/api/v2/platform/categories/#{category_a.id}/reposition", headers: bearer_token, params: params
      end

      it_behaves_like 'returns 404 HTTP status'
    end

    context 'with correct params' do
      let(:params) do
        {
          category: {
            new_parent_id: category_c.id,
            new_position_idx: 0
          }
        }
      end

      before do
        patch "/api/v2/platform/categories/#{category_a.id}/reposition", headers: bearer_token, params: params
      end

      it_behaves_like 'returns 200 HTTP status'

      it 'category_a can be nested inside another category_c' do
        reload_categories

        expect(category_a.permalink).to eq("#{base_category.root.permalink}/pants/t-shirts")
        expect(category_a.parent_id).to eq(category_c.id)
        expect(category_a.depth).to eq(2)
      end
    end

    context 'with correct params moving within the same category' do
      let(:params) do
        {
          category: {
            new_parent_id: category_b.id,
            new_position_idx: 0
          }
        }
      end

      before do
        patch "/api/v2/platform/categories/#{category_a.id}/reposition", headers: bearer_token, params: params
      end

      it_behaves_like 'returns 200 HTTP status'

      it 're-indexes the category' do
        reload_categories

        expect(category_a.parent_id).to eq(category_b.id)
        expect(category_a.lft).to eq(category_b.lft + 1)
      end
    end

    def reload_categories
      category_a.reload
      category_b.reload
      category_c.reload
    end
  end
end
