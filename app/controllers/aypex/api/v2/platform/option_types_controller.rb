module Aypex
  module Api
    module V2
      module Platform
        class OptionTypesController < ResourceController
          private

          def model_class
            Aypex::OptionType
          end
        end
      end
    end
  end
end
