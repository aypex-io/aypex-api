require "spec_helper"

describe Aypex::Api::V2::Platform::CreditCardSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :credit_card }

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
            cc_type: resource.cc_type,
            default: resource.default,
            deleted_at: resource.deleted_at,
            display_brand: resource.display_brand,
            display_number: resource.display_number,
            last_digits: resource.last_digits,
            month: resource.month,
            year: resource.year,
            name: resource.name,
            private_metadata: {},
            public_metadata: {},
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            payment_method: {
              data: {
                id: resource.payment_method.id.to_s,
                type: :payment_method
              }
            },
            user: {
              data: nil
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
