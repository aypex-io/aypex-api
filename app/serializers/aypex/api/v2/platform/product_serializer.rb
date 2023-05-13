module Aypex
  module Api
    module V2
      module Platform
        class ProductSerializer < BaseSerializer
          include ResourceSerializerConcern
          include DisplayMoneyHelper

          attribute :purchasable do |product|
            product.purchasable?
          end

          attribute :in_stock do |product|
            product.in_stock?
          end

          attribute :backorderable do |product|
            product.backorderable?
          end

          attribute :available do |product|
            product.available?
          end

          attribute :currency do |_product, params|
            params[:currency]
          end

          attribute :price do |product, params|
            price(product, params[:currency])
          end

          attribute :display_price do |product, params|
            display_price(product, params[:currency])
          end

          attribute :compare_at_price do |product, params|
            compare_at_price(product, params[:currency])
          end

          attribute :display_compare_at_price do |product, params|
            display_compare_at_price(product, params[:currency])
          end

          belongs_to :tax_category

          has_one :base_variant,
            object_method_name: :default_variant,
            id_method_name: :default_variant_id,
            record_type: :variant,
            serializer: :variant, if: proc { |product| !product.has_variants? }

          has_many :variants, if: proc { |product| product.has_variants? }
          has_many :images
          has_many :option_types
          has_many :product_properties
          has_many :categories, serializer: :category, record_type: :category do |product, params|
            if params[:store].present?
              product.categories_for_store(params[:store])
            else
              product.categories
            end
          end

          has_many :prices, if: proc { |product| !product.has_variants? }
        end
      end
    end
  end
end
