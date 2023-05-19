require "spec_helper"

describe Aypex::Api::V2::Platform::ImageSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :image }

  let(:product) { create(:product) }
  let(:resource) { create(type, viewable: product) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          attributes: {
            position: resource.position,
            alt: resource.alt,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            original_url: resource.original_url
          },
          relationships: {
            viewable: {
              data: {
                id: product.id.to_s,
                type: :product
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
