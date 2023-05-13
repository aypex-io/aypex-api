require "spec_helper"

describe Aypex::Api::V2::Storefront::AddressSerializer do
  subject { described_class.new(address).serializable_hash }

  let(:address) { create(:address, user: create(:user)) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: address.id.to_s,
          type: :address,
          attributes: {
            firstname: address.firstname,
            lastname: address.lastname,
            address1: address.address1,
            address2: address.address2,
            city: address.city,
            zipcode: address.zipcode,
            phone: address.phone,
            state_name: address.state_name_text,
            state_code: address.state_abbr,
            alternative_phone: address.alternative_phone,
            company: address.company,
            label: address.label,
            country_iso: address.country_iso,
            country_iso3: address.country_iso3,
            country_name: address.country_name,
            public_metadata: address.public_metadata
          },
          relationships: {
            country: {
              data: {
                id: address.country.id.to_s,
                type: :country
              }
            },
            state: {
              data: {
                id: address.state.id.to_s,
                type: :state
              }
            },
            user: {
              data: {
                id: address.user.id.to_s,
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
