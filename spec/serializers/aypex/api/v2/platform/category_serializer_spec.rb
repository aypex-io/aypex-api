require "spec_helper"

describe Aypex::Api::V2::Platform::CategorySerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :category }

  let(:base_category) { create(:base_category, store: store) }
  let(:resource) { create(type, products: create_list(:product, 2, stores: [store]), base_category: base_category) }
  let!(:children) { [create(:category, parent: resource, base_category: base_category), create(:category, parent: resource, base_category: base_category)] }

  context "without products" do
    it do
      expect(subject).to eq(
        {
          data: {
            id: resource.id.to_s,
            type: type,
            links: {
              self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
            },
            attributes: {
              position: resource.position,
              name: resource.name,
              permalink: resource.permalink,
              lft: resource.lft,
              rgt: resource.rgt,
              description: resource.description,
              created_at: resource.created_at,
              updated_at: resource.updated_at,
              meta_title: resource.meta_title,
              meta_description: resource.meta_description,
              meta_keywords: resource.meta_keywords,
              depth: resource.depth,
              pretty_name: resource.pretty_name,
              seo_title: resource.seo_title,
              is_root: resource.root?,
              is_child: resource.child?,
              is_leaf: resource.leaf?,
              public_metadata: {},
              private_metadata: {}
            },
            relationships: {
              parent: {
                data: {
                  id: resource.parent.id.to_s,
                  type: :category
                }
              },
              base_category: {
                data: {
                  id: resource.base_category.id.to_s,
                  type: :base_category
                }
              },
              image: {
                data: {
                  id: resource.image.id.to_s,
                  type: :image
                }
              },
              children: {
                data: [
                  {
                    id: resource.children.first.id.to_s,
                    type: :category
                  },
                  {
                    id: resource.children.second.id.to_s,
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
            id: resource.id.to_s,
            type: type,
            links: {
              self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
            },
            attributes: {
              position: resource.position,
              name: resource.name,
              permalink: resource.permalink,
              lft: resource.lft,
              rgt: resource.rgt,
              description: resource.description,
              created_at: resource.created_at,
              updated_at: resource.updated_at,
              meta_title: resource.meta_title,
              meta_description: resource.meta_description,
              meta_keywords: resource.meta_keywords,
              depth: resource.depth,
              pretty_name: resource.pretty_name,
              seo_title: resource.seo_title,
              is_root: resource.root?,
              is_child: resource.child?,
              is_leaf: resource.leaf?,
              public_metadata: {},
              private_metadata: {}
            },
            relationships: {
              parent: {
                data: {
                  id: resource.parent.id.to_s,
                  type: :category
                }
              },
              base_category: {
                data: {
                  id: resource.base_category.id.to_s,
                  type: :base_category
                }
              },
              image: {
                data: {
                  id: resource.image.id.to_s,
                  type: :image
                }
              },
              products: {
                data: [
                  {
                    id: resource.products.first.id.to_s,
                    type: :product
                  },
                  {
                    id: resource.products.second.id.to_s,
                    type: :product
                  }
                ]
              },
              children: {
                data: [
                  {
                    id: resource.children.first.id.to_s,
                    type: :category
                  },
                  {
                    id: resource.children.second.id.to_s,
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
