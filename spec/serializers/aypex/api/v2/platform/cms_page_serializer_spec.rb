require "spec_helper"

describe Aypex::Api::V2::Platform::CmsPageSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :cms_page }
  let(:resource) { create(:cms_feature_page, cms_sections: create_list(:cms_section_image_hero, 2)) }

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
            title: resource.title,
            meta_title: resource.meta_title,
            content: resource.content,
            meta_description: resource.meta_description,
            visible: resource.visible,
            slug: resource.slug,
            type: resource.type,
            locale: resource.locale,
            deleted_at: resource.deleted_at,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            cms_sections: {
              data: [
                {
                  id: resource.cms_sections.first.id.to_s,
                  type: :cms_section
                },
                {
                  id: resource.cms_sections.second.id.to_s,
                  type: :cms_section
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
