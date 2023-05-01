module Aypex
  module Api
    module V2
      module Platform
        class CategorySerializer < BaseSerializer
          include ResourceSerializerConcern

          attributes :pretty_name, :seo_title

          attribute :is_root do |category|
            category.root?
          end

          attribute :is_child do |category|
            category.child?
          end

          attribute :is_leaf do |category|
            category.leaf?
          end

          belongs_to :parent, record_type: :category, serializer: :category
          belongs_to :base_category, record_type: :base_category

          has_many :children, record_type: :category, serializer: :category
          has_many :products, record_type: :product,
            if: proc { |_category, params| params && params[:include_products] == true }

          has_one :image
        end
      end
    end
  end
end
