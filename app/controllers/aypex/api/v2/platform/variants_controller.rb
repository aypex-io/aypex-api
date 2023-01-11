module Aypex
  module Api
    module V2
      module Platform
        class VariantsController < ResourceController
          private

          def model_class
            Aypex::Variant
          end

          def aypex_permitted_attributes
            super + [:option_value_ids, :price, :currency]
          end
        end
      end
    end
  end
end
