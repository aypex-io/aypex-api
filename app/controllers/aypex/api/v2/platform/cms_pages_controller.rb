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
            [:cms_sections]
          end
        end
      end
    end
  end
end
