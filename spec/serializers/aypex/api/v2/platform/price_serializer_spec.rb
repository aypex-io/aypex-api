require "spec_helper"

describe Aypex::Api::V2::Platform::PriceSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :price }
  let(:resource) { create(:price) }

  it do
    expect(subject).to(
      eq(
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add route and controller for this.
          attributes: {
            currency: resource.currency,
            amount: resource.amount,
            amount_inc_vat: resource.amount_including_vat({}).to_s,
            display_amount: resource.display_amount.to_s,
            display_amount_inc_vat: resource.display_amount_including_vat({}).to_s,
            compared_amount: resource.compared_amount,
            compared_amount_inc_vat: resource.compared_amount_including_vat({}).to_s,
            display_compared_amount: resource.display_compared_amount.to_s,
            display_compared_amount_inc_vat: resource.display_compared_amount_including_vat({}).to_s,
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
