module Aypex
  module Api
    module V2
      module Platform
        class VariantSerializer < BaseSerializer
          include ResourceSerializerConcern
          include DisplayMoneyHelper

          attributes :name, :options_text, :total_on_hand

          attribute :purchasable do |variant|
            variant.purchasable?
          end

          attribute :in_stock do |variant|
            variant.in_stock?
          end

          attribute :backorderable do |variant|
            variant.backorderable?
          end

          attribute :available do |variant|
            variant.available?
          end

          attribute :currency do |_variant, params|
            params[:currency]
          end

          attribute :price do |variant, params|
            price(variant, params[:currency])
          end

          attribute :display_price do |variant, params|
            display_price(variant, params[:currency])
          end

          attribute :compared_price do |variant, params|
            compared_price(variant, params[:currency])
          end

          attribute :display_compared_price do |variant, params|
            display_compared_price(variant, params[:currency])
          end

          belongs_to :product
          belongs_to :tax_category
          has_many :digitals
          has_many :option_values
          has_many :stock_items
          has_many :stock_locations
          has_many :prices, serializer: ->(object, params) {
                                          # Hack for Webhooks Price Issue
                                          object.variant.reload
                                          return Aypex::Api::V2::Platform::PriceSerializer
                                        }, if: proc { |variant| !variant.is_master? }
        end
      end
    end
  end
end
