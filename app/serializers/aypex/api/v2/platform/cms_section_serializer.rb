module Aypex
  module Api
    module V2
      module Platform
        class CmsSectionSerializer < BaseSerializer
          include ResourceSerializerConcern

          belongs_to :cms_page, serializer: :cms_page
          belongs_to :linked_resource, polymorphic: {
            Aypex::Cms::Pages::StandardPage => :cms_page,
            Aypex::Cms::Pages::FeaturePage => :cms_page,
            Aypex::Cms::Pages::Homepage => :cms_page
          }
        end
      end
    end
  end
end
