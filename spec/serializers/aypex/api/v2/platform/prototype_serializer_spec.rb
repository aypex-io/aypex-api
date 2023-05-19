require "spec_helper"

describe Aypex::Api::V2::Platform::PrototypeSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :prototype }

  let(:property) { create(:property) }
  let(:option_type) { create(:option_type) }
  let(:resource) { create(type, properties: [property], option_types: [option_type], categories: [category]) }
  let(:category) { create(:category) }

  it do
    expect(subject).to eq(
      data: {
        id: resource.id.to_s,
        type: type,
        links: {}, # TODO: Add endpoint for this.
        attributes: {
          name: resource.name,
          created_at: resource.created_at,
          updated_at: resource.updated_at,
          public_metadata: resource.public_metadata,
          private_metadata: resource.private_metadata
        },
        relationships: {
          properties: {
            data: [{
              id: property.id.to_s,
              type: :property
            }]
          },
          option_types: {
            data: [{
              id: option_type.id.to_s,
              type: :option_type
            }]
          },
          categories: {
            data: [{
              id: category.id.to_s,
              type: :category
            }]
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
