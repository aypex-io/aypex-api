module Aypex
  module Api
    module V2
      module Platform
        class RolesController < ResourceController
          private

          def model_class
            Aypex::Role
          end
        end
      end
    end
  end
end
