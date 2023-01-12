shared_context "API v2 serializers params" do
  let(:store) { Aypex::Store.default || create(:store, default: true) }
  let(:currency) { store.default_currency }
  let(:locale) { store.default_locale }
  let(:zone) { Aypex::Zone.default_tax || create(:zone, default_tax: true) }

  let(:serializer_params) do
    {
      store: store,
      currency: currency,
      user: nil,
      locale: locale,
      price_options: {tax_zone: zone}
    }
  end
end
