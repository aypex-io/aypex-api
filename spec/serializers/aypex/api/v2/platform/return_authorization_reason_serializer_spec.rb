require "spec_helper"

describe Aypex::Api::V2::Platform::ReturnAuthorizationReasonSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :return_authorization_reason }
  let(:resource) { create(:return_authorization_reason) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Add endpoint?
          attributes: {
            active: resource.active,
            mutable: resource.mutable,
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
