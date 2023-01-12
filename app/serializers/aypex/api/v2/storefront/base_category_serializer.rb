module Aypex
  module Api::V2
    module Storefront
      class BaseCategorySerializer < BaseSerializer
        set_type :base_category

        attributes :name, :position, :public_metadata
      end
    end
  end
end
