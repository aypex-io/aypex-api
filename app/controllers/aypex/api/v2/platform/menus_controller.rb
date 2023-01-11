module Aypex
  module Api
    module V2
      module Platform
        class MenusController < ResourceController
          private

          def model_class
            Aypex::Menu
          end

          def scope_includes
            [:menu_items]
          end
        end
      end
    end
  end
end
