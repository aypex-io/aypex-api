module Aypex
  module Api
    module V2
      module Storefront
        module Account
          class CreditCardsController < ::Aypex::Api::V2::ResourceController
            before_action :require_aypex_current_user

            def destroy
              aypex_authorize! :destroy, resource, resource

              destroy_service.call(card: resource)
            end

            private

            def resource
              params[:id].eql?("default") ? scope.default.first! : scope.find(params[:id])
            end

            def model_class
              Aypex::CreditCard
            end

            def scope
              super.not_expired.not_removed.where(
                user: aypex_current_user,
                payment_method: current_store.payment_methods.available_on_front_end
              )
            end

            def collection_serializer
              Aypex::Api::Dependency.storefront_credit_card_serializer.constantize
            end

            def collection_finder
              Aypex::Api::Dependency.storefront_credit_card_finder.constantize
            end

            def resource_serializer
              Aypex::Api::Dependency.storefront_credit_card_serializer.constantize
            end

            def destroy_service
              Aypex::Api::Dependency.storefront_credit_cards_destroy_service.constantize
            end
          end
        end
      end
    end
  end
end
