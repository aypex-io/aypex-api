module Aypex
  module Api
    module V2
      module Platform
        class AddressesController < ResourceController
          private

          def model_class
            Aypex::Address
          end

          def scope_includes
            [:country, :state, :user]
          end
        end
      end
    end
  end
end
