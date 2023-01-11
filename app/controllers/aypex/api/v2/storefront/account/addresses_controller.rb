module Aypex
  module Api
    module V2
      module Storefront
        module Account
          class AddressesController < ::Aypex::Api::V2::ResourceController
            include Aypex::BaseHelper

            before_action :require_aypex_current_user

            def create
              aypex_authorize! :create, model_class

              result = create_service.call(user: aypex_current_user, address_params: address_params)
              render_result(result)
            end

            def update
              aypex_authorize! :update, resource

              result = update_service.call(address: resource, address_params: address_params)
              render_result(result)
            end

            def destroy
              aypex_authorize! :destroy, resource

              if resource.destroy
                head 204
              else
                render_error_payload(resource.errors)
              end
            end

            private

            def collection
              collection_finder.new(scope: scope, params: finder_params).execute
            end

            def scope
              super.where(user: aypex_current_user, country: available_countries).not_deleted
            end

            def model_class
              Aypex::Address
            end

            def collection_finder
              Aypex::Api::Dependency.storefront_address_finder.constantize
            end

            def collection_serializer
              Aypex::Api::Dependency.storefront_address_serializer.constantize
            end

            def resource_serializer
              Aypex::Api::Dependency.storefront_address_serializer.constantize
            end

            def create_service
              Aypex::Api::Dependency.storefront_address_create_service.constantize
            end

            def update_service
              Aypex::Api::Dependency.storefront_address_update_service.constantize
            end

            def address_params
              params.require(:address).permit(permitted_address_attributes)
            end
          end
        end
      end
    end
  end
end
