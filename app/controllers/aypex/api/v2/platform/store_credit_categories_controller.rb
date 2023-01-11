module Aypex
  module Api
    module V2
      module Platform
        class StoreCreditCategoriesController < ResourceController
          private

          def model_class
            Aypex::StoreCreditCategory
          end
        end
      end
    end
  end
end
