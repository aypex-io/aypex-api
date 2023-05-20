require "spec_helper"

describe Aypex::Api::V2::Platform::StockLocationSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :stock_location }

  let(:resource) { create(type, country: country) }
  let(:type) { :stock_location }
  let(:country) { create(:country) }

  it do
    expect(subject).to eq(
      data: {
        id: resource.id.to_s,
        type: type,
        links: {
          self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
        },
        attributes: {
          active: resource.active,
          address1: resource.address1,
          address2: resource.address2,
          admin_name: resource.admin_name,
          backorderable_default: resource.backorderable_default,
          city: resource.city,
          created_at: resource.created_at,
          default: resource.default,
          name: resource.name,
          phone: resource.phone,
          propagate_all_variants: resource.propagate_all_variants,
          state_name: resource.state_name,
          updated_at: resource.updated_at,
          zipcode: resource.zipcode
        },
        relationships: {
          country: {
            data: {
              id: country.id.to_s,
              type: :country
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
