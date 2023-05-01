module Aypex
  module Api
    module V2
      module Platform
        class MenuItemSerializer < BaseSerializer
          include ResourceSerializerConcern

          attributes :link

          attribute :is_container do |menu_item|
            menu_item.container?
          end

          attribute :is_root do |menu_item|
            menu_item.root?
          end

          attribute :is_child do |menu_item|
            menu_item.child?
          end

          attribute :is_leaf do |menu_item|
            menu_item.leaf?
          end

          has_one :image

          belongs_to :menu, serializer: :menu
          belongs_to :parent, record_type: :menu_item, serializer: :menu_item
          belongs_to :linked_resource, polymorphic: {
            Aypex::Cms::Page::StandardPage => :cms_page,
            Aypex::Cms::Page::FeaturePage => :cms_page,
            Aypex::Cms::Page::Homepage => :cms_page
          }

          has_many :children, record_type: :menu_item, serializer: :menu_item
        end
      end
    end
  end
end
