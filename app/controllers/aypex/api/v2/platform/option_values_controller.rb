module Aypex
  module Api
    module V2
      module Platform
        class OptionValuesController < ResourceController
          private

          def model_class
            Aypex::OptionValue
          end

          def scope_includes
            [:option_type]
          end
        end
      end
    end
  end
end
