require "spec_helper"

describe Aypex::Api::V2::Platform::StoreSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :store }

  let!(:resource) { Aypex::Store.default }

  let!(:menus) { [create(:menu, store: resource), create(:menu, location: "Footer", store: resource)] }
  let!(:logo) do
    resource.build_logo
    resource.logo.attachment.attach(io: File.new(Aypex::Engine.root + "spec/fixtures" + "thinking-cat.jpg"), filename: "thinking-cat.jpg")
    resource.save
    resource.logo
  end
  let(:url_helpers) { Rails.application.routes.url_helpers }

  it { expect(subject).to be_a(Hash) }

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
            url: resource.url,
            meta_description: resource.meta_description,
            meta_keywords: resource.meta_keywords,
            seo_title: resource.seo_title,
            mail_from_address: resource.mail_from_address,
            default_currency: resource.default_currency,
            code: resource.code,
            default: resource.default,
            created_at: resource.created_at,
            updated_at: resource.updated_at,
            supported_currencies: resource.supported_currencies,
            facebook: resource.facebook,
            twitter: resource.twitter,
            instagram: resource.instagram,
            default_locale: resource.default_locale,
            customer_support_email: resource.customer_support_email,
            description: resource.description,
            address: resource.address,
            contact_phone: resource.contact_phone,
            new_order_notifications_email: resource.new_order_notifications_email,
            seo_robots: resource.seo_robots,
            supported_locales: resource.supported_locales,
            deleted_at: resource.deleted_at,
            logo: url_helpers.rails_blob_path(resource.logo.attachment),
            mailer_logo: url_helpers.rails_blob_path(resource.mailer_logo.attachment),
            favicon_path: url_helpers.rails_blob_path(resource.favicon_image.attachment),
            address_require_phone_number: resource.address_require_phone_number,
            address_require_alt_phone_number: resource.address_require_alt_phone_number,
            address_show_company_address_field: resource.address_show_company_address_field,
            checkout_allow_guest_checkout: resource.checkout_allow_guest_checkout,
            checkout_alternative_shipping_phone: resource.checkout_alternative_shipping_phone,
            checkout_shipping_instructions: resource.checkout_shipping_instructions,
            checkout_always_include_confirm_step: resource.checkout_always_include_confirm_step,
            show_variant_full_price: resource.show_variant_full_price,
            tax_using_ship_address: resource.tax_using_ship_address,
            use_the_user_preferred_locale: resource.use_the_user_preferred_locale,
            digital_asset_authorized_clicks: resource.digital_asset_authorized_clicks,
            digital_asset_authorized_days: resource.digital_asset_authorized_days,
            digital_asset_link_expire_time: resource.digital_asset_link_expire_time,
            limit_digital_download_count: resource.limit_digital_download_count,
            limit_digital_download_days: resource.limit_digital_download_days,
            return_eligibility_number_of_days: resource.return_eligibility_number_of_days
          },
          relationships: {
            default_country: {
              data: {
                id: resource.default_country.id.to_s,
                type: :country
              }
            },
            menus: {
              data: [
                {
                  id: resource.menus.first.id.to_s,
                  type: :menu
                },
                {
                  id: resource.menus.second.id.to_s,
                  type: :menu
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
