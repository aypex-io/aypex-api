module Aypex
  module Api
    module V2
      module ProductListIncludes
        def product_list_includes
          {
            product_properties: [],
            option_types: [],
            images: [],
            master: product_variant_includes,
            variants: product_variant_includes
          }
        end

        def product_variant_includes
          {
            prices: [],
            option_values: :option_type
          }
        end
      end
    end
  end
end
