module Aypex
  module Api
    module V2
      module Platform
        class CmsComponentSerializer < BaseSerializer
          include ResourceSerializerConcern

          # Action Text Rich Text
          attribute :content, if: proc { |record| record.content? } do |object|
            object.content.to_s
          end

          # Settings based on those available through the ActiveStorage Typed Store
          # on individual STI CMS Components.
          #
          # We are not using settings as this way the attributes are displayed at the top level,
          # and also allows the API user to set them as you would any other attribute, and they will then be
          # type cast as expected.
          attribute :title, if: proc { |record| record.respond_to?(:title) } do |object|
            object.title
          end
          attribute :headline, if: proc { |record| record.respond_to?(:headline) } do |object|
            object.headline
          end
          attribute :subtitle, if: proc { |record| record.respond_to?(:subtitle) } do |object|
            object.subtitle
          end
          attribute :button_text, if: proc { |record| record.respond_to?(:button_text) } do |object|
            object.button_text
          end

          belongs_to :cms_section
          belongs_to :linked_resource, polymorphic: {
            Aypex::Cms::Page::StandardPage => :cms_page,
            Aypex::Cms::Page::FeaturePage => :cms_page,
            Aypex::Cms::Page::Homepage => :cms_page
          }

          has_one :image, serializer: :image
        end
      end
    end
  end
end
