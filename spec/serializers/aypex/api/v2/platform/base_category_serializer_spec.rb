require "spec_helper"

describe Aypex::Api::V2::Platform::BaseCategorySerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :base_category }

  let(:resource) { create(type) }
  let(:category) { create(:category, base_category: base_category) }
  let(:categories_json) do
    resource.categories.map do |category|
      {
        id: category.id.to_s,
        type: :category
      }
    end
  end

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
            updated_at: resource.updated_at,
            position: resource.position,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            root: {
              data: {
                id: resource.root.id.to_s,
                type: :category
              }
            },
            categories: {
              data: categories_json
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
