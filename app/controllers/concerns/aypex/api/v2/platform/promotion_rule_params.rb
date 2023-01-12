module Aypex
  module Api
    module V2
      module Platform
        module PromotionRuleParams
          private

          def rule_params
            [:match_policy, :country_id, :amount_min, :operator_min, :amount_max,
             :operator_max, { category_ids: [], user_ids: [], product_ids: [], eligible_values: {} }]
          end
        end
      end
    end
  end
end
