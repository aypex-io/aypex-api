module Aypex
  module Api
    module V2
      module Platform
        class ShippingCategoriesController < ResourceController
          private

          def model_class
            Aypex::ShippingCategory
          end
        end
      end
    end
  end
end
