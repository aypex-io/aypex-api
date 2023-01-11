module Aypex
  module Api
    module V2
      module Storefront
        class OrderStatusController < ::Aypex::Api::V2::ResourceController
          include Aypex::Api::V2::Storefront::OrderConcern

          before_action :ensure_order_token

          private

          def resource
            resource = resource_finder.new(number: params[:number], token: order_token, store: current_store).execute.take
            raise ActiveRecord::RecordNotFound if resource.nil?

            resource
          end

          def resource_finder
            Aypex::Api::Dependencies.storefront_completed_order_finder.constantize
          end

          def resource_serializer
            Aypex::Api::Dependencies.storefront_cart_serializer.constantize
          end

          def ensure_order_token
            raise ActiveRecord::RecordNotFound unless order_token.present?
          end
        end
      end
    end
  end
end
