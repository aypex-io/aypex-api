module Aypex
  module Api
    module V2
      module Platform
        class PaymentMethodsController < ResourceController
          private

          def model_class
            Aypex::PaymentMethod
          end
        end
      end
    end
  end
end
