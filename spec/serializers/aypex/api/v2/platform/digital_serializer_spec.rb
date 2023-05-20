require "spec_helper"

describe Aypex::Api::V2::Platform::DigitalSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :digital }
  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: :digital,
          attributes: {
            byte_size: resource.attachment.byte_size.to_i,
            content_type: resource.attachment.content_type.to_s,
            filename: resource.attachment.filename.to_s,
            url: Rails.application.routes.url_helpers.polymorphic_url(resource.attachment, only_path: true)
          },
          relationships: {
            variant: {
              data: {
                id: resource.variant.id.to_s,
                type: :variant
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
