require "spec_helper"

describe Aypex::Api::V2::Platform::UserSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :user }
  let(:resource) { create(:user_with_addresses) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {},
          attributes: {
            email: resource.email,
            first_name: resource.first_name,
            last_name: resource.last_name,
            average_order_value: [],
            lifetime_value: [],
            selected_locale: nil,
            store_credits: [],
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            bill_address: {
              data: {
                id: resource.bill_address.id.to_s,
                type: :address
              }
            },
            ship_address: {
              data: {
                id: resource.ship_address.id.to_s,
                type: :address
              }
            }
          }
        }
      }
    )
  end
  it_behaves_like "an ActiveJob serializable hash"

  context "when user has orders" do
    before do
      create(:completed_order_with_totals, user: resource, currency: "USD")
      create(:completed_order_with_totals, user: resource, currency: "EUR")
      create(:store_credit, amount: "100", store: store, user: resource, currency: "USD")
      create(:store_credit, amount: "90", store: store, user: resource, currency: "EUR")
    end

    it do
      expect(subject[:data][:attributes]).to eq({
        email: resource.email,
        first_name: resource.first_name,
        last_name: resource.last_name,
        average_order_value: [{amount: "110.00", currency: "USD"}, {amount: "110.00", currency: "EUR"}],
        lifetime_value: [{amount: "110.00", currency: "USD"}, {amount: "110.00", currency: "EUR"}],
        selected_locale: nil,
        store_credits: [{amount: "100.00", currency: "USD"}, {amount: "90.00", currency: "EUR"}],
        created_at: resource.created_at,
        updated_at: resource.updated_at,
        public_metadata: {},
        private_metadata: {}
      })
    end
  end

  context "when user has selected non default locale" do
    let(:resource) { create(:user_with_addresses, selected_locale: "fr") }

    it "returns the selected locale in the serialized hash" do
      expect(subject[:data][:attributes][:selected_locale]).to eq("fr")
    end
  end
end
