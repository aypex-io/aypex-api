require "spec_helper"

describe Aypex::Api::V2::Platform::RefundReasonSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :refund_reason }
  let(:resource) { create(type) }

  it do
    expect(subject).to eq(
      data: {
        id: resource.id.to_s,
        type: type,
        links: {}, # TODO: Set up route / controller
        attributes: {
          name: resource.name,
          active: resource.active,
          mutable: resource.mutable,
          created_at: resource.created_at,
          updated_at: resource.updated_at
        }
      }
    )
  end
end
