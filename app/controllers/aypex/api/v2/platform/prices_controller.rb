module Aypex
  module Api
    module V2
      module Platform
        class PricesController < ResourceController

          private

          def model_class
            Aypex::Price
          end
        end
      end
    end
  end
end
