module Aypex
  module Api
    module V2
      module Platform
        class CmsComponentSerializer < BaseSerializer
          include ResourceSerializerConcern

          belongs_to :cms_section

          belongs_to :linked_resource, polymorphic: {
            Aypex::Cms::Page::StandardPage => :cms_page,
            Aypex::Cms::Page::FeaturePage => :cms_page,
            Aypex::Cms::Page::Homepage => :cms_page
          }

          has_one :image
        end
      end
    end
  end
end
