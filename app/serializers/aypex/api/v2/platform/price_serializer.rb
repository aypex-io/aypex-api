module Aypex
  module Api
    module V2
      module Platform
        class PriceSerializer < BaseSerializer
          include ResourceSerializerConcern

          attribute :currency
          attribute :amount
          attribute :amount_inc_vat do |price, params|
            price.amount_inc_vat(params[:price_options].presence || {}).to_s
          end
          attribute :display_amount do |price|
            price.display_amount.to_s
          end
          attribute :display_amount_inc_vat do |price, params|
            price.display_amount_inc_vat(params[:price_options].presence || {}).to_s
          end

          attribute :compared_amount
          attribute :compared_amount_inc_vat do |price, params|
            price.compared_amount_inc_vat(params[:price_options].presence || {}).to_s
          end

          attribute :display_compared_amount do |price, params|
            price.display_compared_amount.to_s
          end

          attribute :display_compared_amount_inc_vat do |price, params|
            price.display_compared_amount_inc_vat(params[:price_options].presence || {}).to_s
          end

          # When product has no variants lets tie the price directly to the product.
          belongs_to :variant, if: proc { |price| !price.variant.is_master? }
          belongs_to :product, if: proc { |price| price.variant.is_master? } do |price|
            price.variant.product
          end

          attributes :created_at, :updated_at, :deleted_at
        end
      end
    end
  end
end
