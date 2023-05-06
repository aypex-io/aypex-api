module Aypex
  module Api
    module V2
      module Platform
        class ResourceController < ::Aypex::Api::V2::ResourceController
          # doorkeeper scopes usage: https://github.com/doorkeeper-gem/doorkeeper/wiki/Using-Scopes
          before_action :validate_token_client
          before_action -> { doorkeeper_authorize! :read, :admin }
          before_action -> { doorkeeper_authorize! :write, :admin }, if: :write_request?

          # optional authorization if using a user token instead of app token
          before_action :authorize_aypex_user

          # index and show actions are defined in Aypex::Api::V2::ResourceController

          def create
            resource = model_class.new(permitted_resource_params)
            ensure_current_store(resource)

            if resource.save
              render_serialized_payload(201) { serialize_resource(resource) }
            else
              render_error_payload(resource.errors)
            end
          end

          def update
            resource.assign_attributes(permitted_resource_params)
            ensure_current_store(resource)

            if resource.save
              render_serialized_payload { serialize_resource(resource) }
            else
              render_error_payload(resource.errors)
            end
          end

          def destroy
            if resource.destroy
              head 204
            else
              render_error_payload(resource.errors)
            end
          end

          protected

          def resource_serializer
            serializer_base_name = model_class.to_s.sub("Aypex::", "")
            "Aypex::Api::V2::Platform::#{serializer_base_name}Serializer".constantize
          end

          def collection_serializer
            resource_serializer
          end

          # overwriting to utilize ransack gem for filtering
          # https://github.com/activerecord-hackery/ransack#search-matchers
          def collection
            @collection ||= scope.ransack(params[:filter]).result
          end

          # overwriting to skip cancancan check if API is consumed by an application
          def scope
            return super if aypex_current_user.present?

            super(skip_cancancan: true)
          end

          # We're overwriting this method because the original one calls `dookreeper_authorize`
          # which breaks our application authorizations defined on top of this controller
          def aypex_current_user
            return nil unless doorkeeper_token
            return nil if doorkeeper_token.resource_owner_id.nil?
            return @aypex_current_user if @aypex_current_user

            @aypex_current_user ||= doorkeeper_token.resource_owner
          end

          def access_denied(exception)
            access_denied_401(exception)
          end

          def validate_token_client
            return if doorkeeper_token.nil?

            raise Doorkeeper::Errors::DoorkeeperError if doorkeeper_token.application.nil?
          end

          # if using a user oAuth token we need to check CanCanCan abilities
          # defined in https://github.com/aypex/aypex/blob/master/core/app/models/aypex/ability.rb
          def authorize_aypex_user
            return if aypex_current_user.nil?

            case action_name
            when "create"
              aypex_authorize! :create, model_class
            when "destroy"
              aypex_authorize! :destroy, resource
            when "index"
              aypex_authorize! :read, model_class
            when "show"
              aypex_authorize! :read, resource
            else
              aypex_authorize! :update, resource
            end
          end

          def model_param_name
            model_class.to_s.demodulize.underscore
          end

          def aypex_permitted_attributes
            store_ids = if model_class.method_defined?(:stores)
              [{store_ids: []}]
            else
              []
            end

            model_class.json_api_permitted_attributes + store_ids + metadata_params + settings_params
          end

          def settings_params
            result = []

            if action_name == "update" && resource.class.stored_attributes.any?
              resource.class.stored_attributes.each do |hash|
                result << hash
              end
            end

            result
          end

          def metadata_params
            if model_class.include?(Metadata)
              [{public_metadata: {}, private_metadata: {}}]
            else
              []
            end
          end

          def permitted_resource_params
            params.require(model_param_name).permit(aypex_permitted_attributes)
          end

          def allowed_sort_attributes
            (super << aypex_permitted_attributes).uniq.compact
          end

          def write_request?
            %w[put patch post delete].include?(request.request_method.downcase)
          end
        end
      end
    end
  end
end
