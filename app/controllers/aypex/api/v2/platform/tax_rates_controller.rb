module Aypex
  module Api
    module V2
      module Platform
        class TaxRatesController < ResourceController
          private

          def model_class
            Aypex::TaxRate
          end

          def scope_includes
            [:zone, :tax_category]
          end

          def aypex_permitted_attributes
            super + [calculator_attributes: Aypex::Calculator.json_api_permitted_attributes]
          end
        end
      end
    end
  end
end
