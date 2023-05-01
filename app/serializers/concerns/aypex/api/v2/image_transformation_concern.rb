module Aypex
  module Api
    module V2
      module ImageTransformationConcern
        extend ActiveSupport::Concern

        def self.included(base)
          base.attribute :transformed_url do |image, params|
            unless params.dig(:image_transformation).nil?
              image.generate_url(
                width: params.dig(:image_transformation, :width),
                height: params.dig(:image_transformation, :height),
                quality: params.dig(:image_transformation, :quality),
                format: params.dig(:image_transformation, :format)
              )
            end
          end
        end
      end
    end
  end
end
