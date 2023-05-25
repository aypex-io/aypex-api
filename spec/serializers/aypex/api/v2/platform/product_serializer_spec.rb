require "spec_helper"

describe Aypex::Api::V2::Platform::ProductSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :product }

  let!(:images) { create_list(:image, 2) }
  let(:resource) do
    create(:product_in_stock,
      name: "Test Product",
      price: 10.00,
      compared_price: 15.00,
      variants_including_master: [create(:variant), create(:variant)],
      option_types: create_list(:option_type, 2),
      product_properties: create_list(:product_property, 2),
      categories: create_list(:category, 2),
      images: images,
      tax_category: create(:tax_category))
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
            name: resource.name,
            description: resource.description,
            available_on: resource.available_on,
            make_active_at: resource.make_active_at,
            status: resource.status,
            deleted_at: resource.deleted_at,
            slug: resource.slug,
            meta_description: resource.meta_description,
            meta_keywords: resource.meta_keywords,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            promotionable: resource.promotionable,
            meta_title: resource.meta_title,
            discontinue_on: resource.discontinue_on,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            tax_category: {
              data: {
                id: resource.tax_category.id.to_s,
                type: :tax_category
              }
            },
            variants: {
              data: [
                {
                  id: resource.variants.first.id.to_s,
                  type: :variant
                },
                {
                  id: resource.variants.second.id.to_s,
                  type: :variant
                }
              ],
              links: {
                self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}?include=variants"
              }
            },
            option_types: {
              data: [
                {
                  id: resource.option_types.first.id.to_s,
                  type: :option_type
                },
                {
                  id: resource.option_types.second.id.to_s,
                  type: :option_type
                }
              ]
            },
            product_properties: {
              data: [
                {
                  id: resource.product_properties.first.id.to_s,
                  type: :product_property
                },
                {
                  id: resource.product_properties.second.id.to_s,
                  type: :product_property
                }
              ]
            },
            categories: {
              data: [
                {
                  id: resource.categories.first.id.to_s,
                  type: :category
                },
                {
                  id: resource.categories.second.id.to_s,
                  type: :category
                }
              ]
            },
            images: {
              data: [
                {
                  id: resource.images.first.id.to_s,
                  type: :image
                },
                {
                  id: resource.images.second.id.to_s,
                  type: :image
                }
              ],
              links: {
                self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}?include=images"
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
