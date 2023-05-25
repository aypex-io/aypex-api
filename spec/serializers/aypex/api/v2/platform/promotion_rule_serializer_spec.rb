require "spec_helper"

describe Aypex::Api::V2::Platform::PromotionRuleSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :promotion_rule }
  let!(:resource) { create(type) }

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
            code: resource.code,
            type: resource.type,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            promotion: {
              data: {
                id: resource.promotion.id.to_s,
                type: :promotion
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
