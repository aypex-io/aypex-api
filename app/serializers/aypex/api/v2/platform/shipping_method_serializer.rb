module Aypex
  module Api
    module V2
      module Platform
        class ShippingMethodSerializer < BaseSerializer
          attributes :name, :code, :admin_name, :display_on, :tracking_url, :created_at, :updated_at, :deleted_at, :public_metadata, :private_metadata

          link :self, if: proc { |object, params|
                            Aypex::Engine.routes.url_helpers.respond_to?(:api_v2_platform_shipping_method_url) && params.any?
                          } do |object, params|
            Aypex::Engine.routes.url_helpers.send(:api_v2_platform_shipping_method_url, object.id, host: params[:store][:url], only_path: false)
          end

          has_many :shipping_categories
          has_many :shipping_rates
          belongs_to :tax_category
          has_one :calculator
        end
      end
    end
  end
end
