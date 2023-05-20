require "spec_helper"

describe Aypex::Api::V2::Platform::DigitalLinkSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :digital_link }
  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: :digital_link,
          attributes: {
            access_counter: 0,
            token: resource.token
          },
          relationships: {
            digital: {
              data: {
                id: resource.digital.id.to_s,
                type: :digital
              }
            },
            line_item: {
              data: {
                id: resource.line_item.id.to_s,
                type: :line_item
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
