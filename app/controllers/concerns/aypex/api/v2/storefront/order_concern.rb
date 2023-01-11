module Aypex
  module Api
    module V2
      module Storefront
        module OrderConcern
          private

          def render_order(result)
            if result.success?
              render_serialized_payload { serialized_current_order }
            else
              render_error_payload(result.error)
            end
          end

          def ensure_order
            raise ActiveRecord::RecordNotFound if aypex_current_order.nil?
          end

          def order_token
            request.headers['X-Aypex-Order-Token'] || params[:order_token]
          end

          def aypex_current_order
            @aypex_current_order ||= find_aypex_current_order
          end

          def find_aypex_current_order
            Aypex::Api::Dependency.storefront_current_order_finder.constantize.new.execute(
              store: current_store,
              user: aypex_current_user,
              token: order_token,
              currency: current_currency
            )
          end

          def serialized_current_order
            serialize_resource(aypex_current_order)
          end

          def serialize_order(order)
            ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
              `OrderConcern#serialize_order` is deprecated and will be removed in Aypex 5.0.
              Please use `serializer_resource` method
            DEPRECATION
            serialize_resource(order)
          end
        end
      end
    end
  end
end
