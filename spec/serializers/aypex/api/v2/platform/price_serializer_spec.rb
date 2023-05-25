require "spec_helper"

describe Aypex::Api::V2::Platform::PriceSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :price }
  let(:resource) { create(:price, currency: "EUR") }

  it do
    expect(subject).to(
      eq(
        data: {
          id: resource.id.to_s,
          type: type,
          links: {
            self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
          },
          attributes: {
            currency: resource.currency,
            amount: resource.amount,
            amount_inc_vat: resource.amount_inc_vat({}).to_s,
            display_amount: resource.display_amount.to_s,
            display_amount_inc_vat: resource.display_amount_inc_vat({}).to_s,
            compared_amount: resource.compared_amount,
            compared_amount_inc_vat: resource.compared_amount_inc_vat({}).to_s,
            display_compared_amount: resource.display_compared_amount.to_s,
            display_compared_amount_inc_vat: resource.display_compared_amount_inc_vat({}).to_s,
            deleted_at: resource.deleted_at,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            variant: {
              data: {
                id: resource.variant.id.to_s,
                type: :variant
              }
            }
          }
        }
      )
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
