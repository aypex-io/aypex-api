require "spec_helper"

describe Aypex::Api::V2::Platform::TaxCategorySerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :tax_category }

  let(:resource) { create(:tax_category) }

  it do
    expect(subject).to eq(
      data: {
        id: resource.id.to_s,
        type: type,
        links: {
          self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
        },
        attributes: {
          name: resource.name,
          description: resource.description,
          is_default: resource.is_default,
          deleted_at: resource.deleted_at,
          created_at: resource.created_at,
          updated_at: resource.updated_at,
          tax_code: nil
        },
        relationships: {
          tax_rates: {
            data: []
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
