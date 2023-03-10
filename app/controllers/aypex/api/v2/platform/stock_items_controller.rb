module Aypex
  module Api
    module V2
      module Platform
        class StockItemsController < ResourceController
          private

          def model_class
            Aypex::StockItem
          end

          def scope_includes
            [:variant, :stock_location]
          end
        end
      end
    end
  end
end
