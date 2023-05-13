require "spec_helper"

describe Aypex::Api::V2::Platform::StoreSerializer do
  subject { described_class.new(store).serializable_hash }

  let!(:store) { Aypex::Store.default }
  let!(:menus) { [create(:menu, store: store), create(:menu, location: "Footer", store: store)] }
  let!(:logo) do
    store.build_logo
    store.logo.attachment.attach(io: File.new(Aypex::Engine.root + "spec/fixtures" + "thinking-cat.jpg"), filename: "thinking-cat.jpg")
    store.save
    store.logo
  end
  let(:url_helpers) { Rails.application.routes.url_helpers }

  it { expect(subject).to be_kind_of(Hash) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: store.id.to_s,
          type: :store,
          attributes: {
            name: store.name,
            url: store.url,
            meta_description: store.meta_description,
            meta_keywords: store.meta_keywords,
            seo_title: store.seo_title,
            mail_from_address: store.mail_from_address,
            default_currency: store.default_currency,
            code: store.code,
            default: store.default,
            created_at: store.created_at,
            updated_at: store.updated_at,
            supported_currencies: store.supported_currencies,
            facebook: store.facebook,
            twitter: store.twitter,
            instagram: store.instagram,
            default_locale: store.default_locale,
            customer_support_email: store.customer_support_email,
            description: store.description,
            address: store.address,
            contact_phone: store.contact_phone,
            new_order_notifications_email: store.new_order_notifications_email,
            seo_robots: store.seo_robots,
            supported_locales: store.supported_locales,
            deleted_at: store.deleted_at,
            logo: url_helpers.rails_blob_path(store.logo.attachment),
            mailer_logo: url_helpers.rails_blob_path(store.mailer_logo.attachment),
            favicon_path: url_helpers.rails_blob_path(store.favicon_image.attachment),
            address_require_phone_number: store.address_require_phone_number,
            address_require_alt_phone_number: store.address_require_alt_phone_number,
            address_show_company_address_field: store.address_show_company_address_field,
            checkout_allow_guest_checkout: store.checkout_allow_guest_checkout,
            checkout_alternative_shipping_phone: store.checkout_alternative_shipping_phone,
            checkout_shipping_instructions: store.checkout_shipping_instructions,
            checkout_always_include_confirm_step: store.checkout_always_include_confirm_step,
            show_variant_full_price: store.show_variant_full_price,
            tax_using_ship_address: store.tax_using_ship_address,
            use_the_user_preferred_locale: store.use_the_user_preferred_locale,
            digital_asset_authorized_clicks: store.digital_asset_authorized_clicks,
            digital_asset_authorized_days: store.digital_asset_authorized_days,
            digital_asset_link_expire_time: store.digital_asset_link_expire_time,
            limit_digital_download_count: store.limit_digital_download_count,
            limit_digital_download_days: store.limit_digital_download_days,
            return_eligibility_number_of_days: store.return_eligibility_number_of_days
          },
          relationships: {
            default_country: {
              data: {
                id: store.default_country.id.to_s,
                type: :country
              }
            },
            menus: {
              data: [
                {
                  id: store.menus.first.id.to_s,
                  type: :menu
                },
                {
                  id: store.menus.second.id.to_s,
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
