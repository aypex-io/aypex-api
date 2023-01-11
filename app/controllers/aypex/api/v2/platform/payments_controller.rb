module Aypex
  module Api
    module V2
      module Platform
        class PaymentsController < ResourceController
          include NumberResource

          private

          def model_class
            Aypex::Payment
          end
        end
      end
    end
  end
end
