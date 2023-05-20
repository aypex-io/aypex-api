module Aypex
  module Api
    module V2
      module ResourceSerializerConcern
        include Rails.application.routes.url_helpers
        extend ActiveSupport::Concern

        def self.included(base)
          serializer_base_name = base.to_s.sub(/^Aypex::Api::V2::Platform::/, "").sub(/Serializer$/, "")
          model_klazz = "Aypex::#{serializer_base_name}".constantize

          # set type
          base.set_type model_klazz.json_api_type

          # include standard attributes
          unless model_klazz == Aypex::Price
            base.attributes(*model_klazz.json_api_columns.reject { |k| k.ends_with?("settings") })
          end

          # include money attributes
          display_getter_methods(model_klazz).each do |method_name|
            base.attribute(method_name) do |object|
              object.public_send(method_name).to_s
            end
          end

          # Set the self link
          base.link :self, if: proc { |object, params|
                                 klazz_name = object.class.name.demodulize
                                 path_name = "api_v2_platform_#{klazz_name.underscore}_url".to_sym

                                 Aypex::Engine.routes.url_helpers.respond_to?(path_name.to_sym) && params.any?
                               } do |object, params|
            klazz_name = object.class.name.demodulize
            path_name = "api_v2_platform_#{klazz_name.underscore}_url".to_sym

            Aypex::Engine.routes.url_helpers.send(path_name, object.id, host: params[:store][:url], only_path: false)
          end
        end

        def self.display_getter_methods(model_klazz)
          model_klazz.new.methods.find_all do |method_name|
            next unless method_name.to_s.start_with?("display_")
            next if method_name.to_s.end_with?("=")
            next if [Aypex::Product, Aypex::Variant].include?(model_klazz) && method_name == :display_amount
            next if model_klazz == Aypex::Price

            method_name
          end
        end
      end
    end
  end
end
