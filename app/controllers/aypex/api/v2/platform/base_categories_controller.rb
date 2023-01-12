module Aypex
  module Api
    module V2
      module Platform
        class BaseCategoriesController < ResourceController
          private

          def model_class
            Aypex::BaseCategory
          end

          def scope_includes
            [:categories, :root]
          end
        end
      end
    end
  end
end
