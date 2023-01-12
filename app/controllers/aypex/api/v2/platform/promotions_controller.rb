module Aypex
  module Api
    module V2
      module Platform
        class PromotionsController < ResourceController
          include ::Aypex::Api::V2::Platform::PromotionRuleParams
          include ::Aypex::Api::V2::Platform::PromotionCalculatorParams

          private

          def model_class
            Aypex::Promotion
          end

          def scope_includes
            [:promotion_category, :promotion_rules, :promotion_actions]
          end

          def aypex_permitted_attributes
            conditional_params = (action_name == "update") ? [:id] : []

            super + [{promotion_actions_attributes: Aypex::PromotionAction.json_api_permitted_attributes.concat(conditional_params) + [{
              promotion_action_line_items_attributes: Aypex::PromotionActionLineItem.json_api_permitted_attributes.concat(conditional_params),
              calculator_attributes: Aypex::Calculator.json_api_permitted_attributes.concat(conditional_params, calculator_params)
            }], promotion_rules_attributes: Aypex::PromotionRule.json_api_permitted_attributes.concat(conditional_params, rule_params)}]
          end
        end
      end
    end
  end
end
