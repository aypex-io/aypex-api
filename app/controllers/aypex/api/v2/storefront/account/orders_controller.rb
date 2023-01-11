module Aypex
  module Api
    module V2
      module Storefront
        module Account
          class OrdersController < ::Aypex::Api::V2::ResourceController
            before_action :require_aypex_current_user

            private

            def collection
              collection_finder.new(user: aypex_current_user, store: current_store).execute
            end

            def resource
              resource = resource_finder.new(user: aypex_current_user, number: params[:id], store: current_store).execute.take
              raise ActiveRecord::RecordNotFound if resource.nil?

              resource
            end

            def allowed_sort_attributes
              super << :completed_at
            end

            def collection_serializer
              Aypex::Api::Dependencies.storefront_order_serializer.constantize
            end

            def resource_serializer
              Aypex::Api::Dependencies.storefront_order_serializer.constantize
            end

            def collection_finder
              Aypex::Api::Dependencies.storefront_completed_order_finder.constantize
            end

            def resource_finder
              Aypex::Api::Dependencies.storefront_completed_order_finder.constantize
            end

            def model_class
              Aypex::Order
            end
          end
        end
      end
    end
  end
end
