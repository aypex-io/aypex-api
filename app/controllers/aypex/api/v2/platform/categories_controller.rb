module Aypex
  module Api
    module V2
      module Platform
        class CategoriesController < ResourceController
          include ::Aypex::Api::V2::Platform::NestedSetRepositionConcern

          private

          def successful_reposition_actions
            reload_category_and_set_new_permalink(resource)
            update_permalinks_on_child_categories

            render_serialized_payload { serialize_resource(resource) }
          end

          def reload_category_and_set_new_permalink(category)
            category.reload
            category.set_permalink
            category.save!
          end

          def update_permalinks_on_child_categories
            resource.descendants.each do |category|
              reload_category_and_set_new_permalink(category)
            end
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
            super.merge(include_products: action_name == "show")
          end

          def aypex_permitted_attributes
            super + [:new_parent_id, :new_position_idx]
          end
        end
      end
    end
  end
end
