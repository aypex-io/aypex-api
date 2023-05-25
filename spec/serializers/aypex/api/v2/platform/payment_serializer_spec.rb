require "spec_helper"

describe Aypex::Api::V2::Platform::PaymentSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :payment }
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
            avs_response: resource.avs_response,
            cvv_response_code: resource.cvv_response_code,
            cvv_response_message: resource.cvv_response_message,
            display_amount: resource.display_amount.to_s,
            number: resource.number,
            private_metadata: {},
            public_metadata: {},
            response_code: resource.response_code,
            source_type: resource.source_type,
            state: resource.state,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            log_entries: {
              data: []
            },
            order: {
              data: {
                id: resource.order.id.to_s,
                type: :order
              }
            },
            payment_capture_events: {
              data: []
            },
            payment_method: {
              data: {
                id: resource.payment_method.id.to_s,
                type: :payment_method
              }
            },
            refunds: {
              data: []
            },
            source: {
              data: {
                id: resource.source.id.to_s,
                type: :credit_card
              }
            },
            state_changes: {
              data: []
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
