module Aypex
  module Api::V2
    module Storefront
      class OptionTypeSerializer < BaseSerializer
        set_type :option_type

        attributes :name, :presentation, :position, :public_metadata

        has_many :option_values
      end
    end
  end
end
