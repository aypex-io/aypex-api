module Aypex
  module Api::V2
    module Storefront
      class CategorySerializer < BaseSerializer
        set_type   :category

        attributes :name, :pretty_name, :permalink, :seo_title, :description, :meta_title, :meta_description,
                   :meta_keywords, :left, :right, :position, :depth, :updated_at, :public_metadata

        attribute :is_root do |category|
          category.root?
        end

        attribute :is_child do |category|
          category.child?
        end

        attribute :is_leaf do |category|
          category.leaf?
        end

        belongs_to :parent,   record_type: :category, serializer: :category
        belongs_to :base_category, record_type: :base_category

        has_many   :children, record_type: :category, serializer: :category
        has_many   :products, record_type: :product,
                              if: proc { |_category, params| params && params[:include_products] == true }

        has_one    :image,
                   object_method_name: :icon,
                   id_method_name: :icon_id,
                   record_type: :category_image,
                   serializer: :category_image
      end
    end
  end
end
