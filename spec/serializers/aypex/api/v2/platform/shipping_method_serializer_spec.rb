require "spec_helper"

describe Aypex::Api::V2::Platform::ShippingMethodSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :shipping_method }

  let(:shipping_category) { create(:shipping_category) }
  let(:tax_category) { create(:tax_category) }
  let(:resource) { create(type, shipping_categories: [shipping_category], tax_category: tax_category) }

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
            code: resource.code,
            admin_name: resource.admin_name,
            display_on: resource.display_on,
            tracking_url: resource.tracking_url,
            deleted_at: resource.deleted_at,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            calculator: {
              data: {
                id: resource.calculator.id.to_s,
                type: :calculator
              }
            },
            tax_category: {
              data: {
                id: tax_category.id.to_s,
                type: :tax_category
              }
            },
            shipping_categories: {
              data: [
                {
                  id: resource.shipping_categories.first.id.to_s,
                  type: :shipping_category
                }
              ]
            },
            shipping_rates: {
              data: []
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
