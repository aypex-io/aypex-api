require "spec_helper"

describe Aypex::Api::V2::Platform::RefundSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :refund }
  let(:resource) { create(type, amount: 5.0) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add Endpoint?
          attributes: {
            amount: resource.amount,
            display_amount: resource.display_amount.to_s,
            private_metadata: {},
            public_metadata: {},
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            log_entries: {
              data: [
                {
                  id: resource.log_entries.first.id.to_s,
                  type: :log_entry
                }
              ]
            },
            payment: {
              data: {
                id: resource.payment.id.to_s,
                type: :payment
              }
            },
            refund_reason: {
              data: {
                id: resource.reason.id.to_s,
                type: :refund_reason
              }
            },
            reimbursement: {
              data: nil
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
