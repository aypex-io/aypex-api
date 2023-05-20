require "spec_helper"

describe Aypex::Api::V2::Platform::Webhooks::SubscriberSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :subscriber }

  let(:resource) { create(type) }
  it do
    expect(subject).to eq(
      data: {
        id: resource.id.to_s,
        type: type,
        links: {},
        attributes: {
          active: resource.active,
          created_at: resource.created_at,
          subscriptions: resource.subscriptions,
          updated_at: resource.updated_at,
          url: resource.url
        }
      }
    )
  end
end
