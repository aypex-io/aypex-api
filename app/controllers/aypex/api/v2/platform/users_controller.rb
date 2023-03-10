module Aypex
  module Api
    module V2
      module Platform
        class UsersController < ResourceController
          private

          def model_class
            Aypex::Config.user_class
          end

          def resource_serializer
            Aypex::Api::V2::Platform::UserSerializer
          end

          def scope_includes
            [:ship_address, :bill_address]
          end

          # we need to define this here as developers can configure their own `user_class`
          def model_param_name
            "user"
          end

          def aypex_permitted_attributes
            super + [:password, :password_confirmation]
          end
        end
      end
    end
  end
end
