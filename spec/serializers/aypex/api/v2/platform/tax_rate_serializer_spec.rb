require "spec_helper"

describe Aypex::Api::V2::Platform::TaxRateSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :tax_rate }
  let(:resource) { create(type) }

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
            amount: resource.amount,
            created_at: resource.created_at,
            deleted_at: resource.deleted_at,
            included_in_price: resource.included_in_price,
            name: resource.name,
            private_metadata: {},
            public_metadata: {},
            show_rate_in_label: resource.show_rate_in_label,
            updated_at: resource.updated_at
          },
          relationships: {
            tax_category: {
              data: {
                id: resource.tax_category.id.to_s,
                type: :tax_category
              }
            },
            zone: {
              data: {
                id: resource.zone.id.to_s,
                type: :zone
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
