module Aypex
  module Api::V2
    module Storefront
      class PaymentMethodSerializer < BaseSerializer
        set_type :payment_method

        attributes :type, :name, :description, :public_metadata, :settings
      end
    end
  end
end
