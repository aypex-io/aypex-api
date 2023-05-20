module Aypex
  module Api
    module V2
      module TimestampSerializerConcern
        extend ActiveSupport::Concern

        def self.included(base)
          base.attribute :timestamps do |object, params|
            hash = {}
            hash["available_on"] = object.available_on if object.respond_to?(:available_on)
            hash["created_at"] = object.created_at if object.respond_to?(:created_at)
            hash["deleted_at"] = object.deleted_at if object.respond_to?(:deleted_at)
            hash["updated_at"] = object.updated_at if object.respond_to?(:updated_at)

            hash
          end
        end
      end
    end
  end
end
