module Aypex
  module Api
    module V2
      module Platform
        class CmsSectionSerializer < BaseSerializer
          include ResourceSerializerConcern

          belongs_to :cms_page, serializer: :cms_page

          has_many :cms_components, serializer: :cms_component
        end
      end
    end
  end
end
