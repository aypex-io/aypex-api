module Aypex
  module Webhooks
    module Subscribers
      class MakeRequestJob < Aypex::BaseJob
        queue_as :aypex_webhooks

        def perform(webhook_payload_body, event_name, subscriber)
          Aypex::Webhooks::Subscribers::HandleRequest.new(
            event_name: event_name,
            subscriber: subscriber,
            webhook_payload_body: webhook_payload_body
          ).call
        end
      end
    end
  end
end
