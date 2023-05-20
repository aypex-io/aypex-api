require "spec_helper"

describe Aypex::Api::V2::Platform::VariantSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :variant }

  let!(:resource) { create(type, price: 10, compared_price: 15, tax_category: create(:tax_category)) }
  let!(:digital) { create(:digital, variant: resource) }

  it { expect(subject).to be_kind_of(Hash) }

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
            sku: resource.sku,
            barcode: resource.barcode,
            weight: resource.weight,
            height: resource.height,
            depth: resource.depth,
            deleted_at: resource.deleted_at,
            is_master: resource.is_master,
            cost_price: resource.cost_price,
            position: resource.position,
            cost_currency: resource.cost_currency,
            track_inventory: resource.track_inventory,
            updated_at: resource.updated_at,
            discontinue_on: resource.discontinue_on,
            created_at: resource.created_at,
            name: resource.name,
            options_text: resource.options_text,
            total_on_hand: resource.total_on_hand,
            purchasable: resource.purchasable?,
            in_stock: resource.in_stock?,
            backorderable: resource.backorderable?,
            available: resource.available?,
            currency: currency,
            price: BigDecimal("10"),
            display_price: "$10.00",
            compared_price: BigDecimal("15"),
            display_compared_price: "$15.00",
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            product: {
              data: {
                id: resource.product.id.to_s,
                type: :product
              }
            },
            tax_category: {
              data: {
                id: resource.tax_category.id.to_s,
                type: :tax_category
              }
            },
            option_values: {
              data: [
                {
                  id: resource.option_values.first.id.to_s,
                  type: :option_value
                }
              ]
            },
            digitals: {
              data: [
                {
                  id: resource.digitals.first.id.to_s,
                  type: :digital
                }
              ]
            },
            stock_locations: {
              data: [
                {
                  id: resource.stock_locations.first.id.to_s,
                  type: :stock_location
                }
              ]
            },
            stock_items: {
              data: [
                {
                  id: resource.stock_items.first.id.to_s,
                  type: :stock_item
                }
              ]
            },
            prices: {
              data: [
                {
                  id: resource.prices.first.id.to_s,
                  type: :price
                }
              ]
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
