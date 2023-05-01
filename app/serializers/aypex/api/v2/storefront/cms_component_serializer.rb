module Aypex
  module Api::V2
    module Storefront
      class CmsComponentSerializer < BaseSerializer
        set_type :cms_component

        attributes :settings, :position

        belongs_to :linked_resource, polymorphic: {
          Aypex::Cms::Pages::StandardPage => :cms_page,
          Aypex::Cms::Pages::FeaturePage => :cms_page,
          Aypex::Cms::Pages::Homepage => :cms_page
        }

        belongs_to :cms_section
      end
    end
  end
end
