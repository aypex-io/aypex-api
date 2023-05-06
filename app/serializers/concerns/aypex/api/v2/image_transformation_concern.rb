module Aypex
  module Api
    module V2
      module ImageTransformationConcern
        extend ActiveSupport::Concern

        FIXED_IMAGE_SIZES = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650,
          700, 750, 800, 850, 900, 950, 1000, 1100, 1200, 1300, 1400, 1600, 1800, 2000, 2200, 2400, 2600, 2800, 3000]

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

          # Creates an asset pack of pre-sized images of any determined quality.
          #
          # This looks very messy on the API JSON response but it offers the chance to
          # work with modern build in browser lazy loading <img src="" srcset="" sizes="" loading="lazy" />
          # with just a single API request.
          FIXED_IMAGE_SIZES.each do |size|
            base.attribute "img_#{size}".to_sym, if: proc { |record, params|
                                                       params && params.dig(:images_transformed_to).present?
                                                     } do |object, params|
              object.generate_url(
                quality: params.dig(:images_transformed_to, :quality),
                format: params.dig(:images_transformed_to, :format)
              )
            end
          end
        end
      end
    end
  end
end
