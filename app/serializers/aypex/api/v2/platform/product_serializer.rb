module Aypex
  module Api
    module V2
      module Platform
        class ProductSerializer < BaseSerializer
          include ResourceSerializerConcern
          include DisplayMoneyHelper
          include LinkHelper

          attribute :sku, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.sku
          end

          attribute :weight, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.weight
          end

          attribute :height, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.height
          end

          attribute :depth, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.depth
          end

          attribute :cost_price, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.cost_price
          end

          attribute :track_inventory, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.master.track_inventory
          end

          attribute :total_on_hand, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.master.total_on_hand
          end

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

          attribute :compared_price, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            compared_price(object, params[:currency])
          end

          attribute :display_compared_price, if: proc { |product|
            !product.has_variants?
          } do |object, params|
            display_compared_price(object, params[:currency])
          end

          attribute :barcode, if: proc { |product|
            !product.has_variants?
          } do |object|
            object.barcode
          end

          belongs_to :tax_category

          has_many :variants, if: proc { |product, params| product.has_variants? && params.any? },
            links: {
              self: ->(object, params) {
                related_link(object, params, :variants)
              }
            }

          has_many :images, if: proc { |product, params| product.images.any? && params.any? },
            links: {
              self: ->(object, params) {
                related_link(object, params, :images)
              }
            }

          has_many :option_types
          has_many :product_properties
          has_many :categories, serializer: :category, record_type: :category do |product, params|
            if params[:store].present?
              product.categories_for_store(params[:store])
            else
              product.categories
            end
          end

          has_many :prices, if: proc { |product, params| !product.has_variants? && params.any? },
            links: {
              self: ->(object, params) {
                related_link(object, params, :prices)
              }
            }
        end
      end
    end
  end
end
