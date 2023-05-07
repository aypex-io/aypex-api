module Aypex
  module Api
    module V2
      module ImageTransformationConcern
        extend ActiveSupport::Concern

        def self.included(base)
          base.attribute :transformed_url, if: proc { |record, params|
                                                 params && params.dig(:image_transformation).present?
                                               } do |object, params|
            object.generate_url(
              width: params.dig(:image_transformation, :width),
              height: params.dig(:image_transformation, :height),
              quality: params.dig(:image_transformation, :quality),
              format: params.dig(:image_transformation, :format)
            )
          end

          # Allows the API to request an array of pre sized images in one request.
          # The images will be returned as an array.
          #
          # Options
          # Widths | pass comma separated integer values
          # images_transformed_to[widths]=150,378,550,987,1200
          #
          # Quality | pass a single integer value
          # images_transformed_to[quality]=20
          #
          # Format | pass a single integer value
          # images_transformed_to[format]=webp
          #
          # An example request below.
          # include=image&images_transformed_to[widths]=150,378,550,987,1200&images_transformed_to[quality]=20&images_transformed_to[format]=webp
          base.attribute :images_transformed_to, if: proc { |record, params|
            params && params.dig(:images_transformed_to).present? && params.dig(:images_transformed_to, :widths).present?
          } do |object, params|
            rquested_quality = params.dig(:images_transformed_to, :quality) || "100"
            rquested_format = params.dig(:images_transformed_to, :format) || "webp"
            requested_widths = params.dig(:images_transformed_to, :widths).split(",")
            resulting_array = []

            requested_widths.each do |width|
              resulting_array << {width: width, quality: rquested_quality, format: rquested_format, url: object.generate_url(width: width, quality: rquested_quality, format: rquested_format)}
            end

            resulting_array
          end
        end
      end
    end
  end
end
