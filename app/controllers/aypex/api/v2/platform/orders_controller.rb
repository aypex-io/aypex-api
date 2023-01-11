module Aypex
  module Api
    module V2
      module Platform
        class OrdersController < ResourceController
          include CouponCodesHelper
          include NumberResource

          def create
            resource = current_store.orders.new(permitted_resource_params)

            if resource.save
              render_serialized_payload(201) { serialize_resource(resource) }
            else
              render_error_payload(resource.errors)
            end
          end

          def update
            result = update_service.call(
              order: resource,
              params: params,
              permitted_attributes: aypex_permitted_attributes,
              request_env: request.headers.env
            )

            render_result(result)
          end

          def next
            result = next_service.call(order: resource)

            render_result(result)
          end

          def advance
            result = advance_service.call(order: resource)

            render_result(result)
          end

          def complete
            result = complete_service.call(order: resource)

            render_result(result)
          end

          def empty
            result = empty_service.call(order: resource)

            render_result(result)
          end

          def cancel
            result = cancel_service.call(order: resource, canceler: aypex_current_user)

            render_result(result)
          end

          def approve
            result = approve_service.call(order: resource, approver: aypex_current_user)

            render_result(result)
          end

          def destroy
            result = destroy_service.call(order: resource)

            if result.success?
              head 204
            else
              render_error_payload(result.error)
            end
          end

          def apply_coupon_code
            resource.coupon_code = params[:coupon_code]
            result = coupon_handler.new(resource).apply

            if result.error.blank?
              render_serialized_payload { serialize_resource(resource.reload) }
            else
              render_error_payload(result.error)
            end
          end

          def use_store_credit
            result = use_store_credit_service.call(
              order: resource,
              amount: params[:amount].try(:to_f)
            )

            render_result(result)
          end

          private

          def model_class
            Aypex::Order
          end

          def allowed_sort_attributes
            super.push(:available_on, :make_active_at, :total, :payment_total, :item_total, :shipment_total,
                       :adjustment_total, :promo_total, :included_tax_total, :additional_tax_total,
                       :item_count, :tax_total, :completed_at)
          end

          def update_service
            Aypex::Api::Dependency.platform_order_update_service.constantize
          end

          def next_service
            Aypex::Api::Dependency.platform_order_next_service.constantize
          end

          def advance_service
            Aypex::Api::Dependency.platform_order_advance_service.constantize
          end

          def use_store_credit_service
            Aypex::Api::Dependency.platform_order_use_store_credit_service.constantize
          end

          def complete_service
            Aypex::Api::Dependency.platform_order_complete_service.constantize
          end

          def empty_service
            Aypex::Api::Dependency.platform_order_empty_service.constantize
          end

          def destroy_service
            Aypex::Api::Dependency.platform_order_destroy_service.constantize
          end

          def approve_service
            Aypex::Api::Dependency.platform_order_approve_service.constantize
          end

          def cancel_service
            Aypex::Api::Dependency.platform_order_cancel_service.constantize
          end

          def coupon_handler
            Aypex::Api::Dependency.platform_coupon_handler.constantize
          end

          def aypex_permitted_attributes
            super + [
              bill_address_attributes: Aypex::Address.json_api_permitted_attributes,
              ship_address_attributes: Aypex::Address.json_api_permitted_attributes,
              line_items_attributes: Aypex::LineItem.json_api_permitted_attributes,
              payments_attributes: Aypex::Payment.json_api_permitted_attributes + [
                source_attributes: Aypex::CreditCard.json_api_permitted_attributes
              ],
              shipments_attributes: Aypex::Shipment.json_api_permitted_attributes
            ]
          end
        end
      end
    end
  end
end
