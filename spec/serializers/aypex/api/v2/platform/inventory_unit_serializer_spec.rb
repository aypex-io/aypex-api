require "spec_helper"

describe Aypex::Api::V2::Platform::InventoryUnitSerializer do
  include_context "API v2 serializers params"

  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :inventory_unit }
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
            pending: resource.pending,
            quantity: resource.quantity,
            state: resource.state,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            line_item: {
              data: {
                id: resource.line_item.id.to_s,
                type: :line_item
              }
            },
            order: {
              data: {
                id: resource.order.id.to_s,
                type: :order
              }
            },
            original_return_item: {
              data: nil
            },
            return_authorizations: {
              data: []
            },
            return_items: {
              data: []
            },
            shipment: {
              data: {
                id: resource.shipment.id.to_s,
                type: :shipment
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
