require "spec_helper"

describe Aypex::Api::V2::Platform::ZoneSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :zone }

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
            created_at: resource.created_at,
            default_tax: resource.default_tax,
            description: resource.description,
            kind: resource.kind,
            name: resource.name,
            updated_at: resource.updated_at,
            zone_members_count: resource.zone_members_count

          },
          relationships: {
            zone_members: {
              data: []
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
