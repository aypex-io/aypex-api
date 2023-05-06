require "swagger_helper"

describe "CMS Section API", swagger: true do
  include_context "Platform API v2"

  resource_name = "CMS Section"
  options = {
    include_example: "cms_components",
    filter_examples: [{name: "filter[name_eq]", example: "Hero"}],
    custom_create_params: {
      oneOf: [
        {"$ref" => "#/components/schemas/create_hero_cms_section_params"},
        {"$ref" => "#/components/schemas/create_product_carousel_cms_section_params"},
        {"$ref" => "#/components/schemas/create_side_by_side_images_cms_section_params"},
        {"$ref" => "#/components/schemas/create_featured_article_cms_section_params"},
        {"$ref" => "#/components/schemas/create_image_gallery_cms_section_params"},
        {"$ref" => "#/components/schemas/create_rich_text_cms_section_params"}
      ]
    },
    custom_update_params: {
      oneOf: [
        {"$ref" => "#/components/schemas/update_hero_cms_section_params"},
        {"$ref" => "#/components/schemas/update_product_carousel_cms_section_params"},
        {"$ref" => "#/components/schemas/update_side_by_side_images_cms_section_params"},
        {"$ref" => "#/components/schemas/update_featured_article_cms_section_params"},
        {"$ref" => "#/components/schemas/update_image_gallery_cms_section_params"},
        {"$ref" => "#/components/schemas/update_rich_text_cms_section_params"}
      ]
    }
  }

  let!(:store) { Aypex::Store.default }
  let!(:cms_page) { create(:cms_feature_page, store: store) }
  let(:cms_section_one) { create(:cms_hero_section, cms_page: cms_page) }
  let(:cms_section_two) { create(:cms_hero_section, cms_page: cms_page) }
  let(:cms_section_three) { create(:cms_hero_section, cms_page: cms_page) }

  let(:id) { create(:cms_hero_section, cms_page: cms_page).id }
  let(:records_list) { create_list(:cms_hero_section, 2, cms_page: cms_page) }

  let(:valid_create_param_value) { build(:cms_hero_section, cms_page: cms_page).attributes }
  let(:valid_update_param_value) do
    {
      name: "Super Hero",
      position: 1,
      type: "Aypex::Cms::Section::Hero"
    }
  end

  let(:invalid_param_value) do
    {
      name: ""
    }
  end

  include_examples "CRUD examples", resource_name, options
end
