require "spec_helper"

describe Aypex::Api::V2::Platform::AddressSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :address }
  let(:resource) { create(type, user: create(:user)) }

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
            firstname: resource.firstname,
            lastname: resource.lastname,
            address1: resource.address1,
            address2: resource.address2,
            city: resource.city,
            zipcode: resource.zipcode,
            phone: resource.phone,
            state_name: resource.state_name,
            alternative_phone: resource.alternative_phone,
            company: resource.company,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            deleted_at: resource.deleted_at,
            label: resource.label,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            country: {
              data: {
                id: resource.country.id.to_s,
                type: :country
              }
            },
            state: {
              data: {
                id: resource.state.id.to_s,
                type: :state
              }
            },
            user: {
              data: {
                id: resource.user.id.to_s,
                type: :user
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
