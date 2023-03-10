module Aypex
  module Api::V2
    module Storefront
      class StateSerializer < BaseSerializer
        set_type :state

        attributes :abbr, :name
      end
    end
  end
end
