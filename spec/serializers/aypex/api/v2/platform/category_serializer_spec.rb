require "spec_helper"

describe Aypex::Api::V2::Platform::CategorySerializer do
  include_context "API v2 serializers params"

  subject { described_class.new(category, params: serializer_params).serializable_hash }

  let(:base_category) { create(:base_category, store: store) }
  let(:category) { create(:category, products: create_list(:product, 2, stores: [store]), base_category: base_category) }
  let!(:children) { [create(:category, parent: category, base_category: base_category), create(:category, parent: category, base_category: base_category)] }

  it { expect(subject).to be_kind_of(Hash) }

  context "without products" do
    it do
      expect(subject).to eq(
        {
          data: {
            id: category.id.to_s,
            type: :category,
            attributes: {
              position: category.position,
              name: category.name,
              permalink: category.permalink,
              lft: category.lft,
              rgt: category.rgt,
              description: category.description,
              created_at: category.created_at,
              updated_at: category.updated_at,
              meta_title: category.meta_title,
              meta_description: category.meta_description,
              meta_keywords: category.meta_keywords,
              depth: category.depth,
              pretty_name: category.pretty_name,
              seo_title: category.seo_title,
              is_root: category.root?,
              is_child: category.child?,
              is_leaf: category.leaf?,
              public_metadata: {},
              private_metadata: {}
            },
            relationships: {
              parent: {
                data: {
                  id: category.parent.id.to_s,
                  type: :category
                }
              },
              base_category: {
                data: {
                  id: category.base_category.id.to_s,
                  type: :base_category
                }
              },
              image: {
                data: {
                  id: category.image.id.to_s,
                  type: :image
                }
              },
              children: {
                data: [
                  {
                    id: category.children.first.id.to_s,
                    type: :category
                  },
                  {
                    id: category.children.second.id.to_s,
                    type: :category
                  }
                ]
              }
            }
          }
        }
      )
    end
  end

  context "with products" do
    before do
      serializer_params[:include_products] = true
    end

    it do
      expect(subject).to eq(
        {
          data: {
            id: category.id.to_s,
            type: :category,
            attributes: {
              position: category.position,
              name: category.name,
              permalink: category.permalink,
              lft: category.lft,
              rgt: category.rgt,
              description: category.description,
              created_at: category.created_at,
              updated_at: category.updated_at,
              meta_title: category.meta_title,
              meta_description: category.meta_description,
              meta_keywords: category.meta_keywords,
              depth: category.depth,
              pretty_name: category.pretty_name,
              seo_title: category.seo_title,
              is_root: category.root?,
              is_child: category.child?,
              is_leaf: category.leaf?,
              public_metadata: {},
              private_metadata: {}
            },
            relationships: {
              parent: {
                data: {
                  id: category.parent.id.to_s,
                  type: :category
                }
              },
              base_category: {
                data: {
                  id: category.base_category.id.to_s,
                  type: :base_category
                }
              },
              image: {
                data: {
                  id: category.image.id.to_s,
                  type: :image
                }
              },
              products: {
                data: [
                  {
                    id: category.products.first.id.to_s,
                    type: :product
                  },
                  {
                    id: category.products.second.id.to_s,
                    type: :product
                  }
                ]
              },
              children: {
                data: [
                  {
                    id: category.children.first.id.to_s,
                    type: :category
                  },
                  {
                    id: category.children.second.id.to_s,
                    type: :category
                  }
                ]
              }
            }
          }
        }
      )
    end
  end

  it_behaves_like "an ActiveJob serializable hash"
end
