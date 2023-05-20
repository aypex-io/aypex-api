require "swagger_helper"

describe "Prices API", swagger: true do
  include_context "Platform API v2"

  resource_name = "Price"
  options = {
    filter_examples: [{name: "filter[currency_eq]", example: "EUR"},
      {name: "filter[amount_eq]", example: "10"}]
  }

  let(:id) { create(:price, currency: "AUD").id }
  let!(:product) { create(:product) }
  let!(:variant) { product.master }

  let(:records_list) do
    build_list(:price, 3) do |record, index|
      case index
      when 0
        record.amount = 20.95
        record.currency = "RAN"
        record.variant = variant
      when 1
        record.amount = 11.99
        record.currency = "GBP"
        record.variant = variant
      when 2
        record.amount = 19.00
        record.currency = "EUR"
        record.variant = variant
      end

      record.save!
    end
  end

  let(:valid_create_param_value) {
    build(:price, currency: "CAD", amount: 30.00, variant_id: variant.id.to_s).attributes
  }

  let(:valid_update_param_value) do
    {
      amount: 44.44,
      currency: "AED"
    }
  end

  let(:invalid_param_value) do
    {
      variant_id: nil
    }
  end

  include_examples "CRUD examples", resource_name, options
end
