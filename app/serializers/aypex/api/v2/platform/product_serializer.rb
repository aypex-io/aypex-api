module Aypex
  module Api
    module V2
      module Platform
        class ProductSerializer < BaseSerializer
          include ResourceSerializerConcern
          include DisplayMoneyHelper

          attribute :purchasable, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.purchasable?
          end

          attribute :in_stock, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.in_stock?
          end

          attribute :backorderable, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.backorderable?
          end

          attribute :available, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.available?
          end

          attribute :currency, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            params[:currency]
          end

          attribute :price, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            price(object, params[:currency])
          end

          attribute :display_price, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            display_price(object, params[:currency])
          end

          attribute :compare_at_price, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            compare_at_price(object, params[:currency])
          end

          attribute :display_compare_at_price, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            display_compare_at_price(object, params[:currency])
          end

          attribute :barcode, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.barcode
          end

          belongs_to :tax_category

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
