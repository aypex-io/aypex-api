module Aypex
  module Api
    module V2
      module Storefront
        class CategoriesController < ::Aypex::Api::V2::ResourceController
          private

          def collection_serializer
            Aypex::Api::Dependency.storefront_category_serializer.constantize
          end

          def resource_serializer
            Aypex::Api::Dependency.storefront_category_serializer.constantize
          end

          def collection_finder
            Aypex::Api::Dependency.storefront_category_finder.constantize
          end

          def paginated_collection
            @paginated_collection ||= collection_paginator.new(collection, params).call
          end

          def resource
            @resource ||= scope.find_by(permalink: params[:id]) || scope.find(params[:id])
          end

          def model_class
            Aypex::Category
          end

          def scope_includes
            node_includes = %i[icon parent base_category]

            {
              parent: node_includes,
              children: node_includes,
              base_category: [root: node_includes],
              icon: [attachment_attachment: :blob]
            }
          end

          def serializer_params
            super.merge(include_products: action_name == 'show')
          end
        end
      end
    end
  end
end
