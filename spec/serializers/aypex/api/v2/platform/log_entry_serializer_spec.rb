require "spec_helper"

describe Aypex::Api::V2::Platform::LogEntrySerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :log_entry }
  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add endpoint.
          attributes: {
            details: resource.details,
            source_type: resource.source_type,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            source: {
              data: {
                id: resource.source.id.to_s,
                type: :order
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
