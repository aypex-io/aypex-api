require "spec_helper"

describe Aypex::Api::V2::Platform::OrderPromotionSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :order_promotion }
  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Do we need an endpoint maybe just get to view
          attributes: {
            display_amount: resource.display_amount.to_s,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            order: {
              data: {
                id: resource.order.id.to_s,
                type: :order
              }
            },
            promotion: {
              data: {
                id: resource.promotion.id.to_s,
                type: :promotion
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
