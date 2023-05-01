module Aypex
  module Api::V2
    module Storefront
      class ImageSerializer < BaseSerializer
        include ::Aypex::Api::V2::ImageTransformationConcern

        set_type :image

        attributes :position, :alt, :original_url
      end
    end
  end
end
