module Aypex
  module Webhooks
    module Subscribers
      class QueueRequests
        prepend Aypex::ServiceModule::Base

        def call(event_name:, webhook_payload_body:, **options)
          filtered_subscribers(event_name, webhook_payload_body, options).each do |subscriber|
            Aypex::Webhooks::Subscribers::MakeRequestJob.perform_later(
              webhook_payload_body, event_name, subscriber
            )
          end
        end

        private

        def filtered_subscribers(event_name, _, _)
          Aypex::Webhooks::Subscriber.active.with_urls_for(event_name)
        end
      end
    end
  end
end
