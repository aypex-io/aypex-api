require "swagger_helper"

describe "BaseCategories API", swagger: true do
  include_context "Platform API v2"

  resource_name = "Base Category"
  options = {
    include_example: "categories,root",
    filter_examples: [{name: "filter[name_eq]", example: "Categories"}]
  }

  let(:id) { create(:base_category, store: store).id }
  let(:records_list) { create_list(:base_category, 2) }
  let(:valid_create_param_value) { build(:base_category).attributes }
  let(:valid_update_param_value) do
    {
      name: "Categories",
      position: 1,
      public_metadata: {balanced: true}
    }
  end
  let(:invalid_param_value) do
    {
      name: ""
    }
  end

  include_examples "CRUD examples", resource_name, options
end
