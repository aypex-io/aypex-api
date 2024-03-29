require "spec_helper"

describe Aypex::Api::V2::Storefront::MenuItemSerializer do
  subject { described_class.new(menu_item) }

  let(:menu) { create(:menu) }
  let(:menu_item) { create(:menu_item, menu: menu, linked_resource: create(:category)) }
  let!(:children) { create(:menu_item, parent_id: menu_item.id, menu: menu) }

  it { expect(subject.serializable_hash).to be_kind_of(Hash) }

  it do
    expect(subject.serializable_hash).to eq(
      {
        data: {
          id: menu_item.id.to_s,
          type: :menu_item,
          attributes: {
            code: menu_item.code,
            name: menu_item.name,
            subtitle: menu_item.subtitle,
            link: menu_item.link,
            new_window: menu_item.new_window,
            lft: menu_item.lft,
            rgt: menu_item.rgt,
            depth: menu_item.depth,
            is_container: false,
            is_root: false,
            is_child: true,
            destination: menu_item.destination,
            is_leaf: true,
            item_type: menu_item.item_type
          },
          relationships: {
            image: {
              data: {
                id: menu_item.image.id.to_s,
                type: :image
              }
            },
            menu: {
              data: {
                id: menu_item.menu.id.to_s,
                type: :menu
              }
            },
            parent: {
              data: {
                id: menu_item.menu.root.id.to_s,
                type: :menu_item
              }
            },
            linked_resource: {
              data: {
                id: menu_item.linked_resource.id.to_s,
                type: :category
              }
            },
            children: {
              data: [
                {
                  id: menu_item.children.first.id.to_s,
                  type: :menu_item
                }
              ]
            }
          }
        }
      }
    )
  end
end
