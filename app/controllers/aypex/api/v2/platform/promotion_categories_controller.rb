module Aypex
  module Api
    module V2
      module Platform
        class PromotionCategoriesController < ResourceController
          private

          def model_class
            Aypex::PromotionCategory
          end

          def scope_includes
            [:promotions]
          end
        end
      end
    end
  end
end
