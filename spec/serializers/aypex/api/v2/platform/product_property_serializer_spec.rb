require "spec_helper"

describe Aypex::Api::V2::Platform::ProductPropertySerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :product_property }
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
            value: resource.value,
            position: resource.position,
            show_property: resource.show_property,
            filter_param: resource.filter_param,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
