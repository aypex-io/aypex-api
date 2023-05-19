require "spec_helper"

describe Aypex::Api::V2::Platform::WishlistSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :wishlist }

  let!(:user) { create(:user) }
  let!(:resource) { create(type, user: user) }
  let!(:wished_item) { create(:wished_item, wishlist: resource) }

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
            is_default: false,
            is_private: true,
            token: resource.token,
            variant_included: false,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            wished_items: {
              data: [
                {
                  id: resource.wished_items.first.id.to_s,
                  type: :wished_item
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
