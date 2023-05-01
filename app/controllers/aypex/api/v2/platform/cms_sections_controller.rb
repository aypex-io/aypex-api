module Aypex
  module Api
    module V2
      module Platform
        class CmsSectionsController < ResourceController
          private

          def model_class
            Aypex::CmsSection
          end
        end
      end
    end
  end
end
