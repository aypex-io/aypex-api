require "spec_helper"

describe Aypex::Api::V2::Platform::WishedItemSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :wished_item }

  let!(:user) { create(:user) }
  let!(:variant) { create(:variant) }
  let!(:wishlist) { create(:wishlist, user: user) }
  let!(:resource) { create(type, wishlist: wishlist, variant: variant, quantity: 3) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: :wished_item,
          links: {
            self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
          },
          attributes: {
            quantity: 3,
            price: resource.price(currency: "USD").to_s,
            total: resource.total(currency: "USD").to_s,
            display_price: resource.display_price(currency: "USD").to_s,
            display_total: resource.display_total(currency: "USD").to_s,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            variant: {
              data:
                {
                  id: variant.id.to_s,
                  type: :variant
                }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
