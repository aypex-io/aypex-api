require "spec_helper"

describe Aypex::Api::V2::Platform::CmsSectionSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :cms_section }

  let(:cms_page) { create(:cms_feature_page) }
  let(:resource) { create(:cms_section_featured_article, cms_page: cms_page) }

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
            type: resource.type,
            position: resource.position,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            cms_page: {
              data: {
                id: resource.cms_page.id.to_s,
                type: :cms_page
              }
            },
            cms_components: {
              data: [
                {
                  id: resource.cms_components.first.id.to_s,
                  type: :cms_component
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
