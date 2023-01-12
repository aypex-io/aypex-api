module Aypex
  module Api
    class Configuration
      attr_writer :api_v2_serializers_cache_ttl, :api_v2_collection_cache_ttl,
        :api_v2_per_page_limit, :api_v2_collection_cache_namespace, :api_v2_content_type

      def api_v2_serializers_cache_ttl
        # 1 hour in seconds
        self.api_v2_serializers_cache_ttl = 3600 unless @api_v2_serializers_cache_ttl

        if @api_v2_serializers_cache_ttl.is_a?(Integer)
          @api_v2_serializers_cache_ttl
        else
          raise "Aypex::Config.api_v2_serializers_cache_ttl MUST be an Integer"
        end
      end

      def api_v2_collection_cache_ttl
        # 1 hour in seconds
        self.api_v2_collection_cache_ttl = 3600 unless @api_v2_collection_cache_ttl

        if @api_v2_collection_cache_ttl.is_a?(Integer)
          @api_v2_collection_cache_ttl
        else
          raise "Aypex::Config.api_v2_collection_cache_ttl MUST be an Integer"
        end
      end

      def api_v2_per_page_limit
        self.api_v2_per_page_limit = 500 unless @api_v2_per_page_limit

        if @api_v2_per_page_limit.is_a?(Integer)
          @api_v2_per_page_limit
        else
          raise "Aypex::Config.api_v2_per_page_limit MUST be an Integer"
        end
      end

      def api_v2_collection_cache_namespace
        self.api_v2_collection_cache_namespace = "api_v2_collection_cache" unless @api_v2_collection_cache_namespace

        if @api_v2_collection_cache_namespace.is_a?(String)
          @api_v2_collection_cache_namespace
        else
          raise "Aypex::Config.api_v2_collection_cache_namespace MUST be an String"
        end
      end

      def api_v2_content_type
        self.api_v2_content_type = "application/vnd.api+json" unless @api_v2_content_type

        if @api_v2_content_type.is_a?(String)
          @api_v2_content_type
        else
          raise "Aypex::Config.api_v2_content_type MUST be an String"
        end
      end
    end
  end
end
