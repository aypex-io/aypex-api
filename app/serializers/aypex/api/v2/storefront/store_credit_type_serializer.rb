module Aypex
  module Api::V2
    module Storefront
      class StoreCreditTypeSerializer < BaseSerializer
        set_type :store_credit_type

        attributes :name
      end
    end
  end
end
