module Aypex
  module Api
    module V2
      module Platform
        class StoresController < ResourceController
          private

          def model_class
            Aypex::Store
          end

          def scope_includes
            [:menus]
          end
        end
      end
    end
  end
end
