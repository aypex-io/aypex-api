require "spec_helper"

describe Aypex::Api::V2::Platform::StoreCreditCategorySerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :store_credit_category }
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
            name: resource.name,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
