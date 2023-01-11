module Aypex
  module Api
    module V2
      module Platform
        class CountriesController < ResourceController
          private

          def model_class
            Aypex::Country
          end

          def scope_includes
            [:states, :zones]
          end
        end
      end
    end
  end
end
