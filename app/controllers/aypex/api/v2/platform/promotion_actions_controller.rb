module Aypex
  module Api
    module V2
      module Platform
        class PromotionActionsController < ResourceController
          include ::Aypex::Api::V2::Platform::PromotionCalculatorParams

          private

          def model_class
            Aypex::PromotionAction
          end

          def scope_includes
            [:promotion]
          end

          def aypex_permitted_attributes
            conditional_params = action_name == 'update' ? [:id] : []

            super + [{
              promotion_action_line_items_attributes: Aypex::PromotionActionLineItem.json_api_permitted_attributes.concat(conditional_params),
              calculator_attributes: Aypex::Calculator.json_api_permitted_attributes.concat(conditional_params, calculator_params)
            }]
          end
        end
      end
    end
  end
end
