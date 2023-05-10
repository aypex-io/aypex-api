require "spec_helper"

describe "Storefront API v2 CMS Pages spec" do
  let(:store) { Aypex::Store.default }

  before { store.update!(supported_locales: "en,fr") }
  after { store.update!(supported_locales: "en") }

  describe "cms_pages#index" do
    let!(:home_page_en) { create(:cms_homepage, store: store) }
    let!(:standard_page_en) { create(:cms_standard_page, store: store, title: "About us") }
    let!(:home_page_fr) { create(:cms_homepage, store: store, locale: "fr") }
    let!(:standard_page_fr) { create(:cms_standard_page, store: store, locale: "fr") }
    let!(:home_page_belonging_to_store_2) { create(:cms_homepage, store: create(:store)) }

    context "with no params" do
      before { get "/api/v2/storefront/cms_pages" }

      it_behaves_like "returns 200 HTTP status"
      it "returns all pages for the current store matching the current locale" do
        expect(json_response["data"].pluck(:id)).to contain_exactly(home_page_en.id.to_s, standard_page_en.id.to_s)
      end
    end

    context "with locale params set to fr" do
      before { get "/api/v2/storefront/cms_pages?locale=fr" }

      it_behaves_like "returns 200 HTTP status"

      it "returns all pages for the current store and specified locale" do
        expect(json_response["data"].pluck(:id)).to contain_exactly(home_page_fr.id.to_s, standard_page_fr.id.to_s)
      end
    end

    context "when filtering by type" do
      shared_examples "returns proper records" do
        before { get "/api/v2/storefront/cms_pages?filter[type]=#{kind}" }

        it_behaves_like "returns 200 HTTP status"

        it "returns pages for the current store and specified kind" do
          expect(json_response["data"].pluck(:id)).to contain_exactly(page.id.to_s)
        end
      end

      context "home" do
        let(:kind) { "home" }
        let(:page) { home_page_en }

        it_behaves_like "returns proper records"
      end

      context "standard" do
        let(:kind) { "standard" }
        let(:page) { standard_page_en }

        it_behaves_like "returns proper records"
      end

      context "feature" do
        let(:kind) { "feature" }
        let!(:page) { create(:cms_feature_page, store: store) }

        it_behaves_like "returns proper records"
      end

      context "non-existing type" do
        before { get "/api/v2/storefront/cms_pages?filter[type]=non-existing" }

        it_behaves_like "returns 200 HTTP status"

        it "returns all records" do
          expect(json_response["data"].pluck(:id)).to contain_exactly(home_page_en.id.to_s, standard_page_en.id.to_s)
        end
      end
    end

    context "filtering by title" do
      before { get "/api/v2/storefront/cms_pages?filter[title]=about" }

      it_behaves_like "returns 200 HTTP status"

      it "returns page with title containing the query" do
        expect(json_response["data"].pluck(:id)).to contain_exactly(standard_page_en.id.to_s)
      end
    end

    context "including cms_sections with cms_components" do
      let(:base_category) { create(:base_category, store: store) }
      let!(:cms_section) { create(:cms_section_featured_article, cms_page: home_page_en) }

      before { get "/api/v2/storefront/cms_pages?include=cms_sections.cms_components" }

      it_behaves_like "returns 200 HTTP status"

      it "returns sections and their associations" do
        expect(json_response["included"]).to include(
          have_type("cms_component")
            .and(have_id(cms_section.cms_components.first.id.to_s))
            .and(have_jsonapi_attributes(:settings, :position))
        )

        expect(json_response["included"]).to include(
          have_type("cms_section")
            .and(
              have_id(cms_section.id.to_s)
              .and(have_relationship(:cms_components))
              .and(have_jsonapi_attributes(:settings, :position))
            )
        )
      end
    end
  end

  describe "cms_pages#show" do
    context "with valid page ID" do
      let!(:subject) { create(:cms_standard_page, store: store) }
      let!(:base_category) { create(:base_category, store: store) }
      let!(:category) { create(:category, base_category: base_category) }
      let!(:page_item) { create(:cms_section_image_hero, cms_page: subject) }

      before { get "/api/v2/storefront/cms_pages/#{subject.id}?include=cms_sections.cms_components" }

      it_behaves_like "returns 200 HTTP status"

      it "returns correct cms_page attributes and relationships" do
        expect(json_response["data"]).to have_type("cms_page")
        expect(json_response["data"]).to have_relationships(:cms_sections)
        expect(json_response["data"]["id"]).to eq(subject.id.to_s)
        expect(json_response["data"]["attributes"]["title"]).to eq(subject.title)
        expect(json_response["data"]["attributes"]["locale"]).to eq(subject.locale)
        expect(json_response["data"]["attributes"]["content"]).to eq(subject.content)
        expect(json_response["data"]["attributes"]["meta_description"]).to eq(subject.meta_description)
        expect(json_response["data"]["attributes"]["meta_title"]).to eq(subject.meta_title)
        expect(json_response["data"]["attributes"]["slug"]).to eq(subject.slug)
        expect(json_response["data"]["attributes"]["type"]).to eq(subject.type)

        expect(json_response["included"]).to include(
          have_type("cms_section")
          .and(have_id(page_item.id.to_s)
            .and(have_relationship(:cms_components)
              )
            )
          )
      end
    end

    context "requesting a page from different store" do
      let!(:page) { create(:cms_standard_page, store: create(:store)) }

      before { get "/api/v2/storefront/cms_pages/#{page.id}" }

      it_behaves_like "returns 404 HTTP status"
    end

    context "with non-existing page ID" do
      before { get "/api/v2/storefront/cms_pages/0" }

      it_behaves_like "returns 404 HTTP status"
    end
  end
end
