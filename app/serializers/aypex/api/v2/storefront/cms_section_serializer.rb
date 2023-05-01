module Aypex
  module Api::V2
    module Storefront
      class CmsSectionSerializer < BaseSerializer
        set_type :cms_section

        attributes :name, :settings, :position, :type

        has_many :cms_components
      end
    end
  end
end
