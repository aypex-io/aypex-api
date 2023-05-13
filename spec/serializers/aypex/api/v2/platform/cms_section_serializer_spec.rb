require "spec_helper"

describe Aypex::Api::V2::Platform::CmsSectionSerializer do
  subject { described_class.new(cms_section).serializable_hash }

  let(:cms_page) { create(:cms_feature_page) }
  let(:cms_section) { create(:cms_section_featured_article, cms_page: cms_page) }

  it { expect(subject).to be_kind_of(Hash) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: cms_section.id.to_s,
          type: :cms_section,
          attributes: {
            name: cms_section.name,
            type: cms_section.type,
            position: cms_section.position,
            created_at: cms_section.created_at,
            updated_at: cms_section.updated_at
          },
          relationships: {
            cms_page: {
              data: {
                id: cms_section.cms_page.id.to_s,
                type: :cms_page
              }
            },
            cms_components: {
              data: [
                {
                  id: cms_section.cms_components.first.id.to_s,
                  type: :cms_component
                }
              ]
            }
          }
        }
      }
    )
  end
end
