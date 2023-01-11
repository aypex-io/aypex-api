module Aypex
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace Aypex::Api
    end
  end
end
