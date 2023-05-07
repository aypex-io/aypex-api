module Aypex
  module Api
    module V2
      module Platform
        class CmsComponentsController < ResourceController
          private

          def model_class
            Aypex::CmsComponent
          end

          def aypex_permitted_attributes
            super + [:content]
          end
        end
      end
    end
  end
end
