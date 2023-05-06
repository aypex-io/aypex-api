module Aypex
  module Api::V2
    module Storefront
      class CmsComponentSerializer < BaseSerializer
        set_type :cms_component

        attributes :settings, :position

        belongs_to :linked_resource, polymorphic: {
          Aypex::Cms::Page::StandardPage => :cms_page,
          Aypex::Cms::Page::FeaturePage => :cms_page,
          Aypex::Cms::Page::Homepage => :cms_page
        }

        belongs_to :cms_section
        has_one :image
      end
    end
  end
end
