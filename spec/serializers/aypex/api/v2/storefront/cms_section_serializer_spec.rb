require "spec_helper"

describe Aypex::Api::V2::Storefront::CmsSectionSerializer do
  subject { described_class.new(cms_section) }

  let(:cms_section) { create(:cms_section_featured_article) }

  shared_examples "returns proper hash" do
    it { expect(subject.serializable_hash).to be_a(Hash) }

    it do
      expect(subject.serializable_hash).to eq(
        {
          data: {
            id: cms_section.id.to_s,
            type: :cms_section,
            attributes: {
              name: cms_section.name,
              settings: cms_section.settings,
              type: cms_section.type,
              position: cms_section.position
            },
            relationships: {
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

  context "cms_section_featured_article" do
    let!(:store) { create(:store) }
    let!(:homepage) { create(:cms_homepage, store: store) }
    let(:cms_section) do
      create(:cms_section_featured_article, cms_page: homepage)
    end

    it_behaves_like "returns proper hash"
  end
end
