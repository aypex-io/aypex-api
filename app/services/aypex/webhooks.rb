module Aypex
  module Webhooks
    def self.disable_webhooks
      webhooks_disabled_previously = ENV["DISABLE_AYPEX_WEBHOOKS"]
      begin
        ENV["DISABLE_AYPEX_WEBHOOKS"] = "true"
        yield
      ensure
        ENV["DISABLE_AYPEX_WEBHOOKS"] = webhooks_disabled_previously
      end
    end
  end
end
