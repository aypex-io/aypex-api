module Aypex
  module Api::V2
    module Storefront
      class CategoryImageSerializer < BaseSerializer
        include ::Aypex::Api::V2::CategoryImageTransformationConcern

        set_type :category_image

        attributes :styles, :alt, :original_url
      end
    end
  end
end
