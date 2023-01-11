module Aypex
  module Api
    module V2
      module Platform
        class CalculatorSerializer < BaseSerializer
          include ResourceSerializerConcern

          attributes :type, :settings
        end
      end
    end
  end
end
