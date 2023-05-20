require "spec_helper"

describe Aypex::Api::V2::Platform::OptionValueSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :option_value }

  let(:resource) { create(type) }

  it { expect(subject).to be_kind_of(Hash) }

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
            position: resource.position,
            name: resource.name,
            presentation: resource.presentation,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            option_type: {
              data: {
                id: resource.option_type.id.to_s,
                type: :option_type
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
