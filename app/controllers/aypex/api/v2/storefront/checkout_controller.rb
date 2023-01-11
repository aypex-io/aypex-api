module Aypex
  module Api
    module V2
      module Storefront
        class CheckoutController < ::Aypex::Api::V2::BaseController
          include Aypex::Api::V2::Storefront::OrderConcern
          before_action :ensure_order

          def next
            aypex_authorize! :update, aypex_current_order, order_token

            result = next_service.call(order: aypex_current_order)

            render_order(result)
          end

          def advance
            aypex_authorize! :update, aypex_current_order, order_token

            result = advance_service.call(order: aypex_current_order)

            render_order(result)
          end

          def complete
            aypex_authorize! :update, aypex_current_order, order_token

            result = complete_service.call(order: aypex_current_order)

            render_order(result)
          end

          def update
            aypex_authorize! :update, aypex_current_order, order_token

            result = update_service.call(
              order: aypex_current_order,
              params: params,
              # defined in https://github.com/aypex/aypex/blob/master/core/lib/aypex/core/controller_helpers/strong_parameters.rb#L19
              permitted_attributes: permitted_checkout_attributes,
              request_env: request.headers.env
            )

            render_order(result)
          end

          def create_payment
            result = create_payment_service.call(order: aypex_current_order, params: params)

            if result.success?
              render_serialized_payload(201) { serialize_resource(aypex_current_order.reload) }
            else
              render_error_payload(result.error)
            end
          end

          def select_shipping_method
            result = select_shipping_method_service.call(order: aypex_current_order, params: params)

            render_order(result)
          end

          def add_store_credit
            aypex_authorize! :update, aypex_current_order, order_token

            result = add_store_credit_service.call(
              order: aypex_current_order,
              amount: params[:amount].try(:to_f)
            )

            render_order(result)
          end

          def remove_store_credit
            aypex_authorize! :update, aypex_current_order, order_token

            result = remove_store_credit_service.call(order: aypex_current_order)
            render_order(result)
          end

          def shipping_rates
            result = shipping_rates_service.call(order: aypex_current_order)

            if result.success?
              render_serialized_payload { serialize_shipping_rates(result.value) }
            else
              render_error_payload(result.error)
            end
          end

          def payment_methods
            render_serialized_payload { serialize_payment_methods(aypex_current_order.available_payment_methods) }
          end

          private

          def resource_serializer
            Aypex::Api::Dependency.storefront_cart_serializer.constantize
          end

          def next_service
            Aypex::Api::Dependency.storefront_checkout_next_service.constantize
          end

          def advance_service
            Aypex::Api::Dependency.storefront_checkout_advance_service.constantize
          end

          def add_store_credit_service
            Aypex::Api::Dependency.storefront_checkout_add_store_credit_service.constantize
          end

          def remove_store_credit_service
            Aypex::Api::Dependency.storefront_checkout_remove_store_credit_service.constantize
          end

          def complete_service
            Aypex::Api::Dependency.storefront_checkout_complete_service.constantize
          end

          def update_service
            Aypex::Api::Dependency.storefront_checkout_update_service.constantize
          end

          def payment_methods_serializer
            Aypex::Api::Dependency.storefront_payment_method_serializer.constantize
          end

          def shipping_rates_service
            Aypex::Api::Dependency.storefront_checkout_get_shipping_rates_service.constantize
          end

          def shipping_rates_serializer
            Aypex::Api::Dependency.storefront_shipment_serializer.constantize
          end

          def create_payment_service
            Aypex::Api::Dependency.storefront_payment_create_service.constantize
          end

          def select_shipping_method_service
            Aypex::Api::Dependency.storefront_checkout_select_shipping_method_service.constantize
          end

          def serialize_payment_methods(payment_methods)
            payment_methods_serializer.new(payment_methods, params: serializer_params).serializable_hash
          end

          def serialize_shipping_rates(shipments)
            shipping_rates_serializer.new(
              shipments,
              params: serializer_params,
              include: [:shipping_rates, :stock_location, :line_items]
            ).serializable_hash
          end
        end
      end
    end
  end
end
