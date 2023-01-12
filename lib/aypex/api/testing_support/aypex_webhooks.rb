RSpec.configure do |config|
  config.before(:each, :aypex_webhooks) do
    ENV["DISABLE_AYPEX_WEBHOOKS"] = nil
  end

  config.after(:each, :aypex_webhooks) do
    ENV["DISABLE_AYPEX_WEBHOOKS"] = "true"
  end
end
