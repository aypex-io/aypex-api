module Aypex
  module Api
    module V2
      module LinkHelper
        extend ActiveSupport::Concern

        included do
          def self.related_link(object, params, attribute)
            klazz_name = object.class.name.demodulize
            path_name = "api_v2_platform_#{klazz_name.underscore}_url".to_sym

            Aypex::Engine.routes.url_helpers.send(path_name, object.id, host: params[:store][:url], only_path: false) + "?include=#{attribute}"
          end
        end
      end
    end
  end
end
