require "spec_helper"

describe Aypex::Api::V2::Platform::AssetSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :asset }

  let(:viewable) { create(:variant) }
  let(:resource) { create(type, viewable: viewable) }

  it do
    expect(subject).to eq(
      data: {
        id: resource.id.to_s,
        type: type,
        links: {}, # TODO: Add endpoint.
        attributes: {
          viewable_type: resource.viewable_type,
          position: resource.position,
          alt: resource.alt,
          created_at: resource.created_at,
          updated_at: resource.updated_at,
          public_metadata: resource.public_metadata,
          private_metadata: resource.private_metadata
        },
        relationships: {
          viewable: {
            data: {
              id: viewable.id.to_s,
              type: :variant
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
