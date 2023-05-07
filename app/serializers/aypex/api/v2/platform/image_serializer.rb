module Aypex
  module Api
    module V2
      module Platform
        class ImageSerializer < BaseSerializer
          include ::Aypex::Api::V2::ImageTransformationConcern

          set_type :image

          attributes :position, :alt, :created_at, :updated_at, :original_url

          belongs_to :viewable, polymorphic: {
            Aypex::Cms::Component::FeaturedArticle => :cms_component,
            Aypex::Cms::Component::ImageHero => :cms_component,
            Aypex::Cms::Component::ImageMosaic => :cms_component,
            Aypex::Cms::Component::ImagePair => :cms_component,
            Aypex::Cms::Component::RichText => :cms_component,
            Aypex::Cms::Component::ProductCarousel => :cms_component
          }
        end
      end
    end
  end
end
