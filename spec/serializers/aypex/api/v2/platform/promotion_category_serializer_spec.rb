require "spec_helper"

describe Aypex::Api::V2::Platform::PromotionCategorySerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :promotion_category }

  let(:resource) { create(type, name: "2021 Promotions", code: "2021-PROMOS") }
  let!(:promtion_a) { create(:promotion, promotion_category: resource) }
  let!(:promtion_b) { create(:promotion, promotion_category: resource) }

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
            code: resource.code,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            promotions: {
              data: [
                {
                  id: resource.promotions.first.id.to_s,
                  type: :promotion
                },
                {
                  id: resource.promotions.second.id.to_s,
                  type: :promotion
                }
              ]
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
