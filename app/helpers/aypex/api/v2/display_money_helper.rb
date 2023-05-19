module Aypex
  module Api
    module V2
      module DisplayMoneyHelper
        extend ActiveSupport::Concern

        class_methods do
          def find_price(product_or_variant, currency)
            product_or_variant.price_in(currency)
          end

          def price(product_or_variant, currency)
            price = find_price(product_or_variant, currency)
            return nil if price.new_record?

            price.amount
          end

          def display_price(product_or_variant, currency)
            price = find_price(product_or_variant, currency)
            return nil if price.new_record?

            Aypex::Money.new(price.amount, currency: currency).to_s
          end

          def compared_price(product_or_variant, currency)
            price = find_price(product_or_variant, currency)
            return nil if price.new_record? || price.compared_amount.blank?

            price.compared_amount
          end

          def display_compared_price(product_or_variant, currency)
            price = find_price(product_or_variant, currency)
            return nil if price.new_record? || price.compared_amount.blank?

            Aypex::Money.new(price.compared_amount, currency: currency).to_s
          end
        end
      end
    end
  end
end
