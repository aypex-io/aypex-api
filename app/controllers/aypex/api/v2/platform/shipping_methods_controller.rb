module Aypex
  module Api
    module V2
      module Platform
        class ShippingMethodsController < ResourceController
          private

          def model_class
            Aypex::ShippingMethod
          end

          def aypex_permitted_attributes
            super + [
              {
                shipping_category_ids: [],
                calculator_attributes: {}
              }
            ]
          end
        end
      end
    end
  end
end
