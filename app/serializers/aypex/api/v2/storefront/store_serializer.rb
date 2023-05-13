module Aypex
  module Api::V2
    module Storefront
      class StoreSerializer < BaseSerializer
        include Aypex::Api::V2::StoreMediaSerializerImagesConcern

        set_type :store

        attributes :name, :url, :meta_description, :meta_keywords, :seo_title, :default_currency,
          :default, :supported_currencies, :facebook, :twitter, :instagram, :default_locale,
          :customer_support_email, :description, :address, :contact_phone, :supported_locales,
          :address_require_phone_number, :address_require_alt_phone_number,
          :address_show_company_address_field, :checkout_allow_guest_checkout, :checkout_alternative_shipping_phone,
          :checkout_shipping_instructions, :checkout_always_include_confirm_step, :show_variant_full_price, :tax_using_ship_address,
          :use_the_user_preferred_locale, :digital_asset_authorized_clicks, :digital_asset_authorized_days, :digital_asset_link_expire_time,
          :limit_digital_download_count, :limit_digital_download_days, :return_eligibility_number_of_days

        # aypex_admin_settings Store Settings
        attribute :admin_products_per_page, if: proc { |record| record.respond_to?(:admin_products_per_page) } do |object|
          object.admin_products_per_page
        end
        attribute :admin_orders_per_page, if: proc { |record| record.respond_to?(:admin_orders_per_page) } do |object|
          object.admin_orders_per_page
        end
        attribute :admin_properties_per_page, if: proc { |record| record.respond_to?(:admin_properties_per_page) } do |object|
          object.admin_properties_per_page
        end
        attribute :admin_promotions_per_page, if: proc { |record| record.respond_to?(:admin_promotions_per_page) } do |object|
          object.admin_promotions_per_page
        end
        attribute :admin_customer_returns_per_page, if: proc { |record| record.respond_to?(:admin_customer_returns_per_page) } do |object|
          object.admin_customer_returns_per_page
        end
        attribute :admin_users_per_page, if: proc { |record| record.respond_to?(:admin_users_per_page) } do |object|
          object.admin_users_per_page
        end
        attribute :admin_variants_per_page, if: proc { |record| record.respond_to?(:admin_variants_per_page) } do |object|
          object.admin_variants_per_page
        end
        attribute :admin_menus_per_page, if: proc { |record| record.respond_to?(:admin_menus_per_page) } do |object|
          object.admin_menus_per_page
        end
        attribute :admin_show_version, if: proc { |record| record.respond_to?(:admin_show_version) } do |object|
          object.admin_show_version
        end
        attribute :admin_product_wysiwyg_editor_enabled, if: proc { |record| record.respond_to?(:admin_product_wysiwyg_editor_enabled) } do |object|
          object.admin_product_wysiwyg_editor_enabled
        end
        attribute :admin_category_wysiwyg_editor_enabled, if: proc { |record| record.respond_to?(:admin_category_wysiwyg_editor_enabled) } do |object|
          object.admin_category_wysiwyg_editor_enabled
        end
        attribute :admin_show_only_complete_orders_by_default, if: proc { |record| record.respond_to?(:admin_show_only_complete_orders_by_default) } do |object|
          object.admin_show_only_complete_orders_by_default
        end

        # aypex_checkout_settings Store Settings (only show if checkout is installed)
        attribute :checkout_shipping_instructions, if: proc { |record| record.respond_to?(:checkout_shipping_instructions) } do |object|
          object.checkout_shipping_instructions
        end
        attribute :checkout_coupon_codes_enabled, if: proc { |record| record.respond_to?(:checkout_coupon_codes_enabled) } do |object|
          object.checkout_coupon_codes_enabled
        end
        attribute :checkout_alternative_shipping_phone, if: proc { |record| record.respond_to?(:checkout_alternative_shipping_phone) } do |object|
          object.checkout_alternative_shipping_phone
        end
        attribute :checkout_allow_guest_checkout, if: proc { |record| record.respond_to?(:checkout_allow_guest_checkout) } do |object|
          object.checkout_allow_guest_checkout
        end
        attribute :checkout_address_requires_phone, if: proc { |record| record.respond_to?(:checkout_address_requires_phone) } do |object|
          object.checkout_address_requires_phone
        end

        has_many :menus
        has_many :cms_pages

        has_one :default_country, serializer: :country, record_type: :country, id_method_name: :default_country_id
      end
    end
  end
end
