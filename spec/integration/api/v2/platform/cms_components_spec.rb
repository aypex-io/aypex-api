require "swagger_helper"

describe "CMS Component API", swagger: true do
  include_context "Platform API v2"

  resource_name = "CMS Component"
  options = {
    include_example: "image",
    filter_examples: [{name: "filter[type_eq]", example: "Aypex::Cms::Component::ImageHero"}],
    custom_create_params: {
      oneOf: [
        {"$ref" => "#/components/schemas/create_hero_cms_component_params"}
      ]
    },
    custom_update_params: {
      oneOf: [
        {"$ref" => "#/components/schemas/update_hero_cms_component_params"}
      ]
    }
  }

  let(:store) { Aypex::Store.default }
  let(:cms_page) { create(:cms_feature_page, store: store) }
  let(:cms_section) { create(:cms_section_image_hero, cms_page: cms_page) }
  let(:cms_component) { create(:cms_component_image_hero, cms_section: cms_section) }

  let(:id) { create(:cms_component_image_hero, cms_section: cms_section).id }
  let(:records_list) { create_list(:cms_component_image_hero, 2, cms_section: cms_section) }

  let(:valid_create_param_value) do
    {
      cms_component: {
        cms_section_id: cms_section.id,
        type: "Aypex::Cms::Component::ImageHero"
      }
    }
  end

  let(:valid_update_param_value) do
    {
      cms_component: {
        title: "This Hero is Amazing!",
        button_text: "Click Now",
        position: 1
      }
    }
  end

  let(:invalid_param_value) do
    {
      cms_component: {
        type: nil
      }
    }
  end

  include_examples "CRUD examples", resource_name, options
end
