require "spec_helper"

describe Aypex::Api::V2::Platform::PaymentMethodSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :payment_method }
  let(:resource) { create(:credit_card_payment_method) }

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
            name: resource.name,
            description: resource.description,
            auto_capture: nil,
            active: resource.active,
            type: resource.type,
            position: resource.position,
            display_on: resource.display_on,
            deleted_at: resource.deleted_at,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            public_metadata: {},
            private_metadata: {},
            test_mode: resource.test_mode,
            dummy_key: resource.dummy_key
          },
          relationships: {
            stores: {
              data: [
                {
                  id: store.id.to_s,
                  type: :store
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
