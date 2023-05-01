module Aypex
  module Api
    module V2
      module Platform
        class CmsPagesController < ResourceController
          private

          def model_class
            Aypex::CmsPage
          end

          def scope_includes
            {
              cms_sections: [
                :cms_components
              ]
            }
          end
        end
      end
    end
  end
end
