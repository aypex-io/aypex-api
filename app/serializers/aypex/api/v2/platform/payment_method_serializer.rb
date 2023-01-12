module Aypex
  module Api
    module V2
      module Platform
        class PaymentMethodSerializer < BaseSerializer
          attributes :name, :type, :description, :active, :display_on, :auto_capture, :position,
            :created_at, :updated_at, :deleted_at, :public_metadata, :private_metadata, :settings

          has_many :stores
        end
      end
    end
  end
end
