require "spec_helper"

describe Aypex::Api::V2::Platform::StateSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :state }

  let(:country) { create(:country) }
  let(:resource) { create(type, country: country) }

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
            abbr: resource.abbr,
            created_at: resource.created_at,
            updated_at: resource.updated_at
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
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
