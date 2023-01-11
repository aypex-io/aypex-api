module Aypex
  module Api
    module V2
      module Storefront
        class AccountController < ::Aypex::Api::V2::ResourceController
          before_action :require_aypex_current_user, except: :create

          def create
            result = create_service.call(user_params: user_create_params)
            render_result(result)
          end

          def update
            aypex_authorize! :update, aypex_current_user
            result = update_service.call(user: aypex_current_user, user_params: user_update_params)
            render_result(result)
          end

          private

          def resource
            aypex_current_user
          end

          def resource_serializer
            Aypex::Api::Dependency.storefront_user_serializer.constantize
          end

          def model_class
            Aypex::Config.user_class
          end

          def create_service
            Aypex::Api::Dependency.storefront_account_create_service.constantize
          end

          def update_service
            Aypex::Api::Dependency.storefront_account_update_service.constantize
          end

          def user_create_params
            user_update_params.except(:bill_address_id, :ship_address_id)
          end

          def user_update_params
            params.require(:user).permit(permitted_user_attributes)
          end
        end
      end
    end
  end
end
