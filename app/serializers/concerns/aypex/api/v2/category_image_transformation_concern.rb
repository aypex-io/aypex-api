module Aypex
  module Api
    module V2
      module CategoryImageTransformationConcern
        extend ActiveSupport::Concern

        def self.included(base)
          base.attribute :transformed_url do |image, params|
            image.generate_url(size: params.dig(:category_image_transformation, :size))
          end
        end
      end
    end
  end
end
