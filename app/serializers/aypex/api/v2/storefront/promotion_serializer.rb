module Aypex
  module Api::V2
    module Storefront
      class PromotionSerializer < BaseSerializer
        set_id :promotion_id
        set_type :promotion

        attributes :name, :description, :amount, :display_amount, :code, :public_metadata
      end
    end
  end
end
