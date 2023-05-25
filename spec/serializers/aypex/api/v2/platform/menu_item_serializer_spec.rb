require "spec_helper"

describe Aypex::Api::V2::Platform::MenuItemSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :menu_item }

  let(:menu) { create(:menu) }
  let(:resource) { create(type, menu: menu, linked_resource: create(:category)) }

  let!(:children) do
    [
      create(:menu_item, parent_id: resource.id, menu: menu),
      create(:menu_item, parent_id: resource.id, menu: menu)
    ]
  end

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {
            self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
          },
          attributes: {
            code: resource.code,
            name: resource.name,
            subtitle: resource.subtitle,
            destination: resource.destination,
            new_window: resource.new_window,
            item_type: resource.item_type,
            is_child: resource.child?,
            is_container: resource.container?,
            is_leaf: resource.leaf?,
            is_root: resource.root?,
            link: resource.link,
            linked_resource_type: resource.linked_resource_type,
            lft: resource.lft,
            rgt: resource.rgt,
            depth: resource.depth,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            image: {
              data: {
                id: resource.image.id.to_s,
                type: :image
              }
            },
            menu: {
              data: {
                id: resource.menu.id.to_s,
                type: :menu
              }
            },
            parent: {
              data: {
                id: resource.menu.root.id.to_s,
                type: :menu_item
              }
            },
            linked_resource: {
              data: {
                id: resource.linked_resource.id.to_s,
                type: :category
              }
            },
            children: {
              data: [
                {
                  id: resource.children.first.id.to_s,
                  type: :menu_item
                },
                {
                  id: resource.children.second.id.to_s,
                  type: :menu_item
                }
              ]
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
