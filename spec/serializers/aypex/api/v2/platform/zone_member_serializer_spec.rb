require "spec_helper"

describe Aypex::Api::V2::Platform::ZoneMemberSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :zone_member }

  let(:resource) { create(type, zoneable: create(:country)) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add Endpoint
          attributes: {
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            zoneable_type: resource.zoneable_type
          },
          relationships: {
            zoneable: {
              data: {
                id: resource.zoneable.id.to_s,
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
