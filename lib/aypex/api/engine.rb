require "rails/engine"

require_relative "dependencies"
require_relative "configuration"

module Aypex
  module Api
    class Engine < Rails::Engine
      isolate_namespace Aypex
      engine_name "aypex_api"

      initializer "aypex.api.environment", before: :load_config_initializers do |_app|
        Aypex::Api::Config = Aypex::Api::Configuration.new
        Aypex::Api::Dependency = Aypex::Api::Dependencies.new
      end

      initializer "aypex.api.checking_migrations" do
        Migrations.new(config, engine_name).check
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/models/aypex/api/webhooks/*_decorator*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end

      def self.root
        @root ||= Pathname.new(File.expand_path("../../..", __dir__))
      end

      config.to_prepare(&method(:activate).to_proc)
    end
  end
end
