module Aypex
  module Api
    module V2
      module Platform
        class PromotionRulesController < ResourceController
          include ::Aypex::Api::V2::Platform::PromotionRuleParams

          private

          def model_class
            Aypex::PromotionRule
          end

          def scope_includes
            [:promotion]
          end

          def aypex_permitted_attributes
            super + rule_params
          end
        end
      end
    end
  end
end
