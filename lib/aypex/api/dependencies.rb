module Aypex
  module Api
    class Dependencies
      include Aypex::DependenciesHelper

      INJECTION_POINTS = [
        :storefront_cart_create_service, :storefront_cart_add_item_service, :storefront_cart_remove_line_item_service,
        :storefront_cart_remove_item_service, :storefront_cart_set_item_quantity_service, :storefront_cart_recalculate_service,
        :storefront_cms_page_serializer, :storefront_cms_page_finder,
        :storefront_cart_update, :storefront_coupon_handler, :storefront_checkout_next_service, :storefront_checkout_advance_service,
        :storefront_checkout_update_service, :storefront_checkout_complete_service, :storefront_checkout_add_store_credit_service,
        :storefront_checkout_remove_store_credit_service, :storefront_checkout_get_shipping_rates_service,
        :storefront_cart_compare_line_items_service, :storefront_cart_serializer, :storefront_credit_card_serializer,
        :storefront_credit_card_finder, :storefront_shipment_serializer, :storefront_payment_method_serializer, :storefront_country_finder,
        :storefront_country_serializer, :storefront_menu_serializer, :storefront_menu_finder, :storefront_current_order_finder,
        :storefront_completed_order_finder, :storefront_order_sorter, :storefront_collection_paginator, :storefront_user_serializer,
        :storefront_products_sorter, :storefront_products_finder, :storefront_product_serializer, :storefront_taxon_serializer,
        :storefront_taxon_finder, :storefront_find_by_variant_finder, :storefront_cart_update_service, :storefront_cart_associate_service,
        :storefront_cart_estimate_shipping_rates_service, :storefront_estimated_shipment_serializer,
        :storefront_store_serializer, :storefront_address_serializer, :storefront_order_serializer,
        :storefront_account_create_address_service, :storefront_account_update_address_service, :storefront_address_finder,
        :storefront_account_create_service, :storefront_account_update_service, :storefront_collection_sorter, :error_handler,
        :storefront_cart_empty_service, :storefront_cart_destroy_service, :storefront_credit_cards_destroy_service, :platform_products_sorter,
        :storefront_cart_change_currency_service, :storefront_payment_serializer,
        :storefront_payment_create_service, :storefront_address_create_service, :storefront_address_update_service,
        :storefront_checkout_select_shipping_method_service,

        :platform_admin_user_serializer, :platform_coupon_handler, :platform_order_update_service,
        :platform_order_use_store_credit_service, :platform_order_remove_store_credit_service,
        :platform_order_complete_service, :platform_order_empty_service, :platform_order_destroy_service,
        :platform_order_next_service, :platform_order_advance_service,
        :platform_line_item_create_service, :platform_line_item_update_service, :platform_line_item_destroy_service,
        :platform_order_approve_service, :platform_order_cancel_service,
        :platform_shipment_change_state_service, :platform_shipment_create_service, :platform_shipment_update_service,
        :platform_shipment_add_item_service, :platform_shipment_remove_item_service
      ].freeze

      attr_accessor(*INJECTION_POINTS)

      def initialize
        set_storefront_defaults
        set_platform_defaults
      end

      private

      def set_storefront_defaults
        # cart services
        @storefront_cart_create_service = Aypex::Dependencies.cart_create_service
        @storefront_cart_add_item_service = Aypex::Dependencies.cart_add_item_service
        @storefront_cart_compare_line_items_service = Aypex::Dependencies.cart_compare_line_items_service
        @storefront_cart_update_service = Aypex::Dependencies.cart_update_service
        @storefront_cart_remove_line_item_service = Aypex::Dependencies.cart_remove_line_item_service
        @storefront_cart_remove_item_service = Aypex::Dependencies.cart_remove_item_service
        @storefront_cart_set_item_quantity_service = Aypex::Dependencies.cart_set_item_quantity_service
        @storefront_cart_recalculate_service = Aypex::Dependencies.cart_recalculate_service
        @storefront_cart_estimate_shipping_rates_service = Aypex::Dependencies.cart_estimate_shipping_rates_service
        @storefront_cart_empty_service = Aypex::Dependencies.cart_empty_service
        @storefront_cart_destroy_service = Aypex::Dependencies.cart_destroy_service
        @storefront_cart_associate_service = Aypex::Dependencies.cart_associate_service
        @storefront_cart_change_currency_service = Aypex::Dependencies.cart_change_currency_service

        # coupon code handler
        @storefront_coupon_handler = Aypex::Dependencies.coupon_handler

        # checkout services
        @storefront_checkout_next_service = Aypex::Dependencies.checkout_next_service
        @storefront_checkout_advance_service = Aypex::Dependencies.checkout_advance_service
        @storefront_checkout_update_service = Aypex::Dependencies.checkout_update_service
        @storefront_checkout_complete_service = Aypex::Dependencies.checkout_complete_service
        @storefront_checkout_add_store_credit_service = Aypex::Dependencies.checkout_add_store_credit_service
        @storefront_checkout_remove_store_credit_service = Aypex::Dependencies.checkout_remove_store_credit_service
        @storefront_checkout_get_shipping_rates_service = Aypex::Dependencies.checkout_get_shipping_rates_service
        @storefront_checkout_select_shipping_method_service = Aypex::Dependencies.checkout_select_shipping_method_service

        # account services
        @storefront_account_create_service = Aypex::Dependencies.account_create_service
        @storefront_account_update_service = Aypex::Dependencies.account_update_service

        # address services
        @storefront_address_create_service = Aypex::Dependencies.address_create_service
        @storefront_address_update_service = Aypex::Dependencies.address_update_service

        # credit card services
        @storefront_credit_cards_destroy_service = Aypex::Dependencies.credit_cards_destroy_service

        # payment services
        @storefront_payment_create_service = Aypex::Dependencies.payment_create_service

        # serializers
        @storefront_address_serializer = 'Aypex::Api::V2::Storefront::AddressSerializer'
        @storefront_cart_serializer = 'Aypex::Api::V2::Storefront::CartSerializer'
        @storefront_cms_page_serializer = 'Aypex::Api::V2::Storefront::CmsPageSerializer'
        @storefront_credit_card_serializer = 'Aypex::Api::V2::Storefront::CreditCardSerializer'
        @storefront_country_serializer = 'Aypex::Api::V2::Storefront::CountrySerializer'
        @storefront_menu_serializer = 'Aypex::Api::V2::Storefront::MenuSerializer'
        @storefront_user_serializer = 'Aypex::Api::V2::Storefront::UserSerializer'
        @storefront_shipment_serializer = 'Aypex::Api::V2::Storefront::ShipmentSerializer'
        @storefront_taxon_serializer = 'Aypex::Api::V2::Storefront::TaxonSerializer'
        @storefront_payment_method_serializer = 'Aypex::Api::V2::Storefront::PaymentMethodSerializer'
        @storefront_payment_serializer = 'Aypex::Api::V2::Storefront::PaymentSerializer'
        @storefront_product_serializer = 'Aypex::Api::V2::Storefront::ProductSerializer'
        @storefront_estimated_shipment_serializer = 'Aypex::Api::V2::Storefront::EstimatedShippingRateSerializer'
        @storefront_store_serializer = 'Aypex::Api::V2::Storefront::StoreSerializer'
        @storefront_order_serializer = 'Aypex::Api::V2::Storefront::OrderSerializer'

        # sorters
        @storefront_collection_sorter = Aypex::Dependencies.collection_sorter
        @storefront_order_sorter = Aypex::Dependencies.collection_sorter
        @storefront_products_sorter = Aypex::Dependencies.products_sorter
        @platform_products_sorter = Aypex::Dependencies.products_sorter

        # paginators
        @storefront_collection_paginator = Aypex::Dependencies.collection_paginator

        # finders
        @storefront_address_finder = Aypex::Dependencies.address_finder
        @storefront_country_finder = Aypex::Dependencies.country_finder
        @storefront_cms_page_finder = Aypex::Dependencies.cms_page_finder
        @storefront_menu_finder = Aypex::Dependencies.menu_finder
        @storefront_current_order_finder = Aypex::Dependencies.current_order_finder
        @storefront_completed_order_finder = Aypex::Dependencies.completed_order_finder
        @storefront_credit_card_finder = Aypex::Dependencies.credit_card_finder
        @storefront_find_by_variant_finder = Aypex::Dependencies.line_item_by_variant_finder
        @storefront_products_finder = Aypex::Dependencies.products_finder
        @storefront_taxon_finder = Aypex::Dependencies.taxon_finder

        @error_handler = 'Aypex::Api::ErrorHandler'
      end

      def set_platform_defaults
        # serializers
        @platform_admin_user_serializer = 'Aypex::Api::V2::Platform::UserSerializer'

        # coupon code handler
        @platform_coupon_handler = Aypex::Dependencies.coupon_handler

        # order services
        @platform_order_recalculate_service = Aypex::Dependencies.cart_recalculate_service
        @platform_order_update_service = Aypex::Dependencies.checkout_update_service
        @platform_order_empty_service = Aypex::Dependencies.cart_empty_service
        @platform_order_destroy_service = Aypex::Dependencies.cart_destroy_service
        @platform_order_next_service = Aypex::Dependencies.checkout_next_service
        @platform_order_advance_service = Aypex::Dependencies.checkout_advance_service
        @platform_order_complete_service = Aypex::Dependencies.checkout_complete_service
        @platform_order_use_store_credit_service = Aypex::Dependencies.checkout_add_store_credit_service
        @platform_order_remove_store_credit_service = Aypex::Dependencies.checkout_remove_store_credit_service
        @platform_order_approve_service = Aypex::Dependencies.order_approve_service
        @platform_order_cancel_service = Aypex::Dependencies.order_cancel_service

        # line item services
        @platform_line_item_create_service = Aypex::Dependencies.line_item_create_service
        @platform_line_item_update_service = Aypex::Dependencies.line_item_update_service
        @platform_line_item_destroy_service = Aypex::Dependencies.line_item_destroy_service

        # shipment services
        @platform_shipment_create_service = Aypex::Dependencies.shipment_create_service
        @platform_shipment_update_service = Aypex::Dependencies.shipment_update_service
        @platform_shipment_change_state_service = Aypex::Dependencies.shipment_change_state_service
        @platform_shipment_add_item_service = Aypex::Dependencies.shipment_add_item_service
        @platform_shipment_remove_item_service = Aypex::Dependencies.shipment_remove_item_service
      end
    end
  end
end
