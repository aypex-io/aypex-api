module Aypex
  module Api::V2
    module Storefront
      class ProductSerializer < BaseSerializer
        include ::Aypex::Api::V2::DisplayMoneyHelper

        set_type :product

        attributes :name, :description, :available_on, :slug, :meta_description, :meta_keywords, :updated_at, :sku, :barcode, :public_metadata

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

        attribute :compared_price do |product, params|
          compared_price(product, params[:currency])
        end

        attribute :display_compared_price do |product, params|
          display_compared_price(product, params[:currency])
        end

        has_many :variants
        has_many :option_types
        has_many :product_properties

        has_many :categories, serializer: :category, record_type: :category do |object, params|
          object.categories_for_store(params[:store]).order(:id)
        end

        # all images from all variants
        has_many :images

        has_one :default_variant,
          object_method_name: :default_variant,
          id_method_name: :default_variant_id,
          record_type: :variant,
          serializer: :variant

        has_one :primary_variant,
          object_method_name: :master,
          id_method_name: :master_id,
          record_type: :variant,
          serializer: :variant
      end
    end
  end
end
