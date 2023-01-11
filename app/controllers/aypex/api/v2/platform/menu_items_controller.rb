module Aypex
  module Api
    module V2
      module Platform
        class MenuItemsController < ResourceController
          include ::Aypex::Api::V2::Platform::NestedSetRepositionConcern

          private

          def model_class
            Aypex::MenuItem
          end

          def aypex_permitted_attributes
            super + [:new_parent_id, :new_position_idx]
          end
        end
      end
    end
  end
end
