require "spec_helper"

describe Aypex::Api::V2::Platform::LineItemSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :line_item }
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
            cost_price: resource.cost_price,
            currency: resource.currency,
            display_additional_tax_total: resource.display_additional_tax_total.to_s,
            display_adjustment_total: resource.display_adjustment_total.to_s,
            display_amount: resource.display_amount.to_s,
            display_discounted_amount: resource.display_discounted_amount.to_s,
            display_final_amount: resource.display_final_amount.to_s,
            display_included_tax_total: resource.display_included_tax_total.to_s,
            display_pre_tax_amount: resource.display_pre_tax_amount.to_s,
            display_price: resource.display_price.to_s,
            display_promo_total: resource.display_promo_total.to_s,
            display_subtotal: resource.display_subtotal.to_s,
            display_total: resource.display_total.to_s,
            included_tax_total: resource.included_tax_total,
            non_taxable_adjustment_total: resource.non_taxable_adjustment_total,
            pre_tax_amount: resource.pre_tax_amount,
            price: resource.price,
            private_metadata: {},
            public_metadata: {},
            promo_total: resource.promo_total,
            quantity: resource.quantity,
            taxable_adjustment_total: resource.taxable_adjustment_total,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            adjustments: {
              data: []
            },
            digital_links: {
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
            tax_category: {
              data: {
                id: resource.tax_category.id.to_s,
                type: :tax_category
              }
            },
            variant: {
              data: {
                id: resource.variant.id.to_s,
                type: :variant
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
