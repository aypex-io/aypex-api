module Aypex
  module Api
    module V2
      module Platform
        class CategoryImageSerializer < BaseSerializer
          include ::Aypex::Api::V2::CategoryImageTransformationConcern

          set_type :category_image

          attributes :alt, :created_at, :updated_at, :original_url
        end
      end
    end
  end
end
