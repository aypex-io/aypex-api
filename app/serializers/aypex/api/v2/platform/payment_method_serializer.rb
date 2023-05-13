module Aypex
  module Api
    module V2
      module Platform
        class PaymentMethodSerializer < BaseSerializer
          attributes :name, :type, :description, :active, :display_on, :auto_capture, :position,
            :created_at, :updated_at, :deleted_at, :public_metadata, :private_metadata

          attribute :test_mode, if: proc { |record| record.respond_to?(:test_mode) } do |object|
            object.test_mode
          end
          attribute :dummy_key, if: proc { |record| record.respond_to?(:dummy_key) } do |object|
            object.dummy_key
          end

          has_many :stores
        end
      end
    end
  end
end
