module Aypex
  module Api
    module V2
      module Storefront
        class CmsPagesController < ::Aypex::Api::V2::ResourceController
          private

          def model_class
            Aypex::CmsPage
          end

          def resource
            @resource ||= scope.find_by(slug: params[:id]) || scope.find(params[:id])
          end

          def resource_serializer
            Aypex::Api::Dependency.storefront_cms_page_serializer.constantize
          end

          def collection_serializer
            Aypex::Api::Dependency.storefront_cms_page_serializer.constantize
          end

          def collection_finder
            Aypex::Api::Dependency.storefront_cms_page_finder.constantize
          end

          def scope
            super.by_locale(I18n.locale)
          end

          def scope_includes
            {
              cms_sections: {
                cms_components: [
                  :linked_resource,
                  :image
                ]
              }
            }
          end
        end
      end
    end
  end
end
