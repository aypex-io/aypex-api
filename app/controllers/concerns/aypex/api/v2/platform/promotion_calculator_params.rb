module Aypex
  module Api
    module V2
      module Platform
        module PromotionCalculatorParams
          private

          def calculator_params
            [:flat_percent, :amount, :first_item, :additional_item,
              :max_items, :percent, :minimal_amount, :normal_amount,
              :discount_amount, :currency, :base_amount, :base_percent, {tiers: {}}]
          end
        end
      end
    end
  end
end
