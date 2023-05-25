require "spec_helper"

describe Aypex::Api::V2::Platform::MenuSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :menu }
  let(:resource) { create(type) }

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
            name: resource.name,
            location: resource.location,
            locale: resource.locale,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            menu_items: {
              data: [
                {
                  id: resource.menu_items.first.id.to_s,
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
