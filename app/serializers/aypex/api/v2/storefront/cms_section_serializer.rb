module Aypex
  module Api::V2
    module Storefront
      class CmsSectionSerializer < BaseSerializer
        set_type :cms_section

        attributes :name, :position, :type

        attribute :is_full_screen, if: proc { |record| record.respond_to?(:is_full_screen) } do |object|
          object.is_full_screen
        end
        attribute :has_gutters, if: proc { |record| record.respond_to?(:has_gutters) } do |object|
          object.has_gutters
        end

        belongs_to :cms_page, serializer: :cms_page

        has_many :cms_components, serializer: :cms_component
      end
    end
  end
end
