require "spec_helper"

describe Aypex::Api::V2::Platform::ShippingRateSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :shipping_rate }

  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add endpoints.
          attributes: {
            cost: resource.cost,
            created_at: resource.created_at,
            display_base_price: resource.display_base_price.to_s,
            display_cost: resource.display_cost.to_s,
            display_final_price: resource.display_final_price.to_s,
            display_price: resource.display_price.to_s,
            display_tax_amount: resource.display_tax_amount.to_s,
            selected: resource.selected,
            updated_at: resource.updated_at
          },
          relationships: {
            shipment: {
              data: {
                id: resource.shipment.id.to_s,
                type: :shipment
              }
            },
            shipping_method: {
              data: {
                id: resource.shipping_method.id.to_s,
                type: :shipping_method
              }
            },
            tax_rate: {
              data: nil
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
