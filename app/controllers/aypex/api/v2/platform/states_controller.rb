module Aypex
  module Api
    module V2
      module Platform
        class StatesController < ResourceController
          private

          def model_class
            Aypex::State
          end

          def scope_includes
            [:country]
          end
        end
      end
    end
  end
end
