module Aypex
  module Webhooks
    def self.table_name_prefix
      'aypex_webhooks_'
    end

    class Base < Aypex::Base
      self.abstract_class = true
    end
  end
end
