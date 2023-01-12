require "swagger_helper"

describe "Classifications API", swagger: true do
  include_context "Platform API v2"

  resource_name = "Classification"
  options = {
    include_example: "product,category",
    filter_examples: [{name: "filter[category_id_eq]", example: "1"}]
  }

  let(:id) { create(:classification).id }
  let(:records_list) { create_list(:classification, 2) }
  let(:product) { create(:product) }
  let(:category) { create(:category) }
  let(:valid_create_param_value) { {position: 1, product_id: product.id, category_id: category.id} }
  let(:valid_update_param_value) do
    {
      position: 1
    }
  end
  let(:invalid_param_value) do
    {
      product_id: nil
    }
  end

  include_examples "CRUD examples", resource_name, options
end
