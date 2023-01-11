module Aypex
  module Api
    module V2
      module Platform
        class DigitalLinksController < ResourceController
          def reset
            aypex_authorize! :update, resource if aypex_current_user.present?

            if resource.reset!
              render_serialized_payload { serialize_resource(resource) }
            else
              render_error_payload(resource.errors)
            end
          end

          private

          def model_class
            Aypex::DigitalLink
          end
        end
      end
    end
  end
end
