require "spec_helper"

describe Aypex::Api::V2::Platform::AdjustmentSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :adjustment }

  let(:resource) { create(:tax_adjustment, order: create(:order)) }

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
            adjustable_type: resource.adjustable_type,
            amount: resource.amount,
            display_amount: resource.display_amount.to_s,
            eligible: resource.eligible,
            included: resource.included,
            label: resource.label,
            mandatory: resource.mandatory,
            source_type: resource.source_type,
            state: resource.state,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            adjustable: {
              data: {
                id: resource.adjustable.id.to_s,
                type: :line_item
              }
            },
            order: {
              data: {
                id: resource.order.id.to_s,
                type: :order
              }
            },
            source: {
              data: {
                id: resource.source.id.to_s,
                type: :tax_rate
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
