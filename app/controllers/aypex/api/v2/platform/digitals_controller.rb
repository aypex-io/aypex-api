module Aypex
  module Api
    module V2
      module Platform
        class DigitalsController < ResourceController
          private

          def model_class
            Aypex::Digital
          end

          def aypex_permitted_attributes
            super + [:attachment]
          end
        end
      end
    end
  end
end
