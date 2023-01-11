module Aypex
  module Api
    module V2
      module Platform
        class ZonesController < ResourceController
          private

          def model_class
            Aypex::Zone
          end

          def scope_includes
            [:zone_members]
          end
        end
      end
    end
  end
end
