module Aypex
  module Api
    module V2
      module Platform
        class StoreCreditTypesController < ResourceController
          private

          def model_class
            Aypex::StoreCreditType
          end
        end
      end
    end
  end
end
