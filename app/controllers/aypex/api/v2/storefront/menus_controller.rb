module Aypex
  module Api
    module V2
      module Storefront
        class MenusController < ::Aypex::Api::V2::ResourceController
          private

          def resource_serializer
            Aypex::Api::Dependency.storefront_menu_serializer.constantize
          end

          def collection_serializer
            Aypex::Api::Dependency.storefront_menu_serializer.constantize
          end

          def collection_finder
            Aypex::Api::Dependency.storefront_menu_finder.constantize
          end

          def model_class
            Aypex::Menu
          end

          def scope
            super.by_locale(I18n.locale)
          end

          def scope_includes
            {
              menu_items: [
                :children,
                :parent,
                :image
              ]
            }
          end
        end
      end
    end
  end
end
