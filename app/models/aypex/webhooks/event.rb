module Aypex
  module Webhooks
    class Event < Aypex::Webhooks::Base
      validates :name, :subscriber, presence: true

      belongs_to :subscriber, inverse_of: :events, optional: false

      self.whitelisted_ransackable_associations = %w[subscriber]
      self.whitelisted_ransackable_attributes = %w[name request_errors response_code success url]
    end
  end
end
