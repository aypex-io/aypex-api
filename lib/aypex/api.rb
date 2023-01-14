require "aypex"
require "aypex/api/engine"
require "jsonapi/serializer"
require "doorkeeper"

module Aypex
  module Api
    # Used to configure Aypex Api.
    #
    # Example:
    #   Aypex::Api.configure do |config|
    #     config.api_v2_per_page_limit = 300
    #   end
    def self.configure
      yield(Aypex::Api::Config)
    end

    # Used to set a new dependency for Aypex Api.
    #
    # Example:
    #   Aypex.set_dependency do |dependency|
    #     dependency.storefront_cart_create_service = MyCustomAddToCart
    #   end
    #
    # This method is defined within the gem on purpose.
    # Some people may only wish to use the part of Aypex Api.
    def self.set_dependency
      yield(Aypex::Api::Dependency)
    end
  end
end
