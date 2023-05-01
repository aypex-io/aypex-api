module Aypex
  module Api
    module V2
      module Platform
        class CmsComponentsController < ResourceController
          private

          def model_class
            Aypex::CmsComponent
          end
        end
      end
    end
  end
end
