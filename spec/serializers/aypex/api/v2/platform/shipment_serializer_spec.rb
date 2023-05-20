require "spec_helper"

describe Aypex::Api::V2::Platform::ShipmentSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :shipment }
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
            additional_tax_total: resource.additional_tax_total,
            adjustment_total: resource.adjustment_total,
            cost: resource.cost,
            display_amount: resource.display_amount.to_s,
            display_cost: resource.display_cost.to_s,
            display_discounted_cost: resource.display_discounted_cost.to_s,
            display_final_price: resource.display_final_price.to_s,
            display_item_cost: resource.display_item_cost.to_s,
            included_tax_total: resource.included_tax_total,
            non_taxable_adjustment_total: resource.non_taxable_adjustment_total,
            number: resource.number,
            pre_tax_amount: resource.pre_tax_amount,
            private_metadata: {},
            promo_total: resource.promo_total,
            public_metadata: {},
            shipped_at: resource.shipped_at,
            state: resource.state,
            taxable_adjustment_total: resource.taxable_adjustment_total,
            tracking: resource.tracking,
            tracking_url: resource.tracking_url,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            address: {
              data: nil
            },
            adjustments: {
              data: []
            },
            inventory_units: {
              data: []
            },
            order: {
              data: {
                id: resource.order.id.to_s,
                type: :order
              }
            },
            selected_shipping_rate: {
              data: {
                id: resource.selected_shipping_rate.id.to_s,
                type: :shipping_rate
              }
            },
            shipping_rates: {
              data: [
                {
                  id: resource.shipping_rates.first.id.to_s,
                  type: :shipping_rate
                }
              ]
            },
            state_changes: {
              data: []
            },
            stock_location: {
              data: {
                id: resource.stock_location.id.to_s,
                type: :stock_location
              }
            }

          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
