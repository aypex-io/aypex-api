module Aypex
  module Api
    module V2
      module Platform
        class AdjustmentsController < ResourceController
          private

          def model_class
            Aypex::Adjustment
          end

          def scope_includes
            [:order, :adjustable]
          end
        end
      end
    end
  end
end
