module Aypex
  module Api::V2
    module Storefront
      class StoreCreditSerializer < BaseSerializer
        set_type :store_credit

        belongs_to :category, serializer: :store_credit_category
        has_many :store_credit_events
        belongs_to :credit_type,
          id_method_name: :type_id,
          serializer: :store_credit_type

        attributes :amount, :amount_used, :created_at, :public_metadata
      end
    end
  end
end
