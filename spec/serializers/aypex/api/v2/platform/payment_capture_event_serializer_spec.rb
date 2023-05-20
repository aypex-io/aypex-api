require "spec_helper"

describe Aypex::Api::V2::Platform::PaymentCaptureEventSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :payment_capture_event }
  let(:resource) { create(:payment_capture_event) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add endpoint?
          attributes: {
            amount: resource.amount,
            display_amount: resource.display_amount.to_s,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            payment: {
              data: {
                id: resource.payment.id.to_s,
                type: :payment
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
