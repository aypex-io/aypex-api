module Aypex
  module Api
    module V2
      module Platform
        module Webhooks
          class SubscribersController < ResourceController
            private

            def model_class
              Aypex::Webhooks::Subscriber
            end

            def aypex_permitted_attributes
              super + [{ subscriptions: [] }]
            end
          end
        end
      end
    end
  end
end
