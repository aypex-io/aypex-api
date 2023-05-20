require "spec_helper"

describe Aypex::Api::V2::Platform::StateChangeSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :state_change }
  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add endpoint.
          attributes: {
            name: resource.name,
            next_state: resource.next_state,
            previous_state: resource.previous_state,
            stateful_type: resource.stateful_type,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            user: {
              data: nil
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
