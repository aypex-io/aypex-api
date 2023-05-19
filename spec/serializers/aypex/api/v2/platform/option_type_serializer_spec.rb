require "spec_helper"

describe Aypex::Api::V2::Platform::OptionTypeSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :option_type }

  let(:resource) { create(type, option_values: create_list(:option_value, 2)) }

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
            presentation: resource.presentation,
            position: resource.position,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            filterable: resource.filterable,
            image_filterable: resource.image_filterable,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            option_values: {
              data: [
                {
                  id: resource.option_values.first.id.to_s,
                  type: :option_value
                },
                {
                  id: resource.option_values.second.id.to_s,
                  type: :option_value
                }
              ]
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
