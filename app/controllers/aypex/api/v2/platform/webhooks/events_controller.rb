module Aypex
  module Api
    module V2
      module Platform
        module Webhooks
          class EventsController < ResourceController
            private

            def model_class
              Aypex::Webhooks::Event
            end

            def scope_includes
              %i[subscriber]
            end
          end
        end
      end
    end
  end
end
