module Aypex
  module Api
    module V2
      module Platform
        class BaseCategorySerializer < BaseSerializer
          include ResourceSerializerConcern

          has_many :categories
          has_one :root, serializer: :category
        end
      end
    end
  end
end
