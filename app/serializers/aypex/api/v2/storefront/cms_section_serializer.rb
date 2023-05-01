module Aypex
  module Api::V2
    module Storefront
      class CmsSectionSerializer < BaseSerializer
        set_type :cms_section

        attributes :name, :settings, :position, :type

        attribute :is_fullscreen do |section|
          section.fullscreen?
        end

        attribute :has_gutters do |section|
          section.gutters?
        end

        has_many :cms_components
      end
    end
  end
end
