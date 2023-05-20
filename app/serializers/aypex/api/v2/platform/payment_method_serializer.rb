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

          link :self, if: proc { |object, params|
                            Aypex::Engine.routes.url_helpers.respond_to?(:api_v2_platform_payment_method_url) && params.any?
                          } do |object, params|
            Aypex::Engine.routes.url_helpers.send(:api_v2_platform_payment_method_url, object.id, host: params[:store][:url], only_path: false)
          end

          has_many :stores
        end
      end
    end
  end
end
