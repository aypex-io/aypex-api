module Aypex
  module Api::V2
    module Storefront
      class ImageSerializer < BaseSerializer
        include ::Aypex::Api::V2::ImageTransformationConcern

        set_type :image

        attributes :styles, :position, :alt, :original_url
      end
    end
  end
end
