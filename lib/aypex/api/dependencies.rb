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
        :storefront_products_sorter, :storefront_products_finder, :storefront_product_serializer, :storefront_category_serializer,
        :storefront_category_finder, :storefront_find_by_variant_finder, :storefront_cart_update_service, :storefront_cart_associate_service,
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
        @storefront_cart_create_service = Aypex::Dependency.cart_create_service
        @storefront_cart_add_item_service = Aypex::Dependency.cart_add_item_service
        @storefront_cart_compare_line_items_service = Aypex::Dependency.cart_compare_line_items_service
        @storefront_cart_update_service = Aypex::Dependency.cart_update_service
        @storefront_cart_remove_line_item_service = Aypex::Dependency.cart_remove_line_item_service
        @storefront_cart_remove_item_service = Aypex::Dependency.cart_remove_item_service
        @storefront_cart_set_item_quantity_service = Aypex::Dependency.cart_set_item_quantity_service
        @storefront_cart_recalculate_service = Aypex::Dependency.cart_recalculate_service
        @storefront_cart_estimate_shipping_rates_service = Aypex::Dependency.cart_estimate_shipping_rates_service
        @storefront_cart_empty_service = Aypex::Dependency.cart_empty_service
        @storefront_cart_destroy_service = Aypex::Dependency.cart_destroy_service
        @storefront_cart_associate_service = Aypex::Dependency.cart_associate_service
        @storefront_cart_change_currency_service = Aypex::Dependency.cart_change_currency_service

        # coupon code handler
        @storefront_coupon_handler = Aypex::Dependency.coupon_handler

        # checkout services
        @storefront_checkout_next_service = Aypex::Dependency.checkout_next_service
        @storefront_checkout_advance_service = Aypex::Dependency.checkout_advance_service
        @storefront_checkout_update_service = Aypex::Dependency.checkout_update_service
        @storefront_checkout_complete_service = Aypex::Dependency.checkout_complete_service
        @storefront_checkout_add_store_credit_service = Aypex::Dependency.checkout_add_store_credit_service
        @storefront_checkout_remove_store_credit_service = Aypex::Dependency.checkout_remove_store_credit_service
        @storefront_checkout_get_shipping_rates_service = Aypex::Dependency.checkout_get_shipping_rates_service
        @storefront_checkout_select_shipping_method_service = Aypex::Dependency.checkout_select_shipping_method_service

        # account services
        @storefront_account_create_service = Aypex::Dependency.account_create_service
        @storefront_account_update_service = Aypex::Dependency.account_update_service

        # address services
        @storefront_address_create_service = Aypex::Dependency.address_create_service
        @storefront_address_update_service = Aypex::Dependency.address_update_service

        # credit card services
        @storefront_credit_cards_destroy_service = Aypex::Dependency.credit_cards_destroy_service

        # payment services
        @storefront_payment_create_service = Aypex::Dependency.payment_create_service

        # serializers
        @storefront_address_serializer = 'Aypex::Api::V2::Storefront::AddressSerializer'
        @storefront_cart_serializer = 'Aypex::Api::V2::Storefront::CartSerializer'
        @storefront_cms_page_serializer = 'Aypex::Api::V2::Storefront::CmsPageSerializer'
        @storefront_credit_card_serializer = 'Aypex::Api::V2::Storefront::CreditCardSerializer'
        @storefront_country_serializer = 'Aypex::Api::V2::Storefront::CountrySerializer'
        @storefront_menu_serializer = 'Aypex::Api::V2::Storefront::MenuSerializer'
        @storefront_user_serializer = 'Aypex::Api::V2::Storefront::UserSerializer'
        @storefront_shipment_serializer = 'Aypex::Api::V2::Storefront::ShipmentSerializer'
        @storefront_category_serializer = 'Aypex::Api::V2::Storefront::CategorySerializer'
        @storefront_payment_method_serializer = 'Aypex::Api::V2::Storefront::PaymentMethodSerializer'
        @storefront_payment_serializer = 'Aypex::Api::V2::Storefront::PaymentSerializer'
        @storefront_product_serializer = 'Aypex::Api::V2::Storefront::ProductSerializer'
        @storefront_estimated_shipment_serializer = 'Aypex::Api::V2::Storefront::EstimatedShippingRateSerializer'
        @storefront_store_serializer = 'Aypex::Api::V2::Storefront::StoreSerializer'
        @storefront_order_serializer = 'Aypex::Api::V2::Storefront::OrderSerializer'

        # sorters
        @storefront_collection_sorter = Aypex::Dependency.collection_sorter
        @storefront_order_sorter = Aypex::Dependency.collection_sorter
        @storefront_products_sorter = Aypex::Dependency.products_sorter
        @platform_products_sorter = Aypex::Dependency.products_sorter

        # paginators
        @storefront_collection_paginator = Aypex::Dependency.collection_paginator

        # finders
        @storefront_address_finder = Aypex::Dependency.address_finder
        @storefront_country_finder = Aypex::Dependency.country_finder
        @storefront_cms_page_finder = Aypex::Dependency.cms_page_finder
        @storefront_menu_finder = Aypex::Dependency.menu_finder
        @storefront_current_order_finder = Aypex::Dependency.current_order_finder
        @storefront_completed_order_finder = Aypex::Dependency.completed_order_finder
        @storefront_credit_card_finder = Aypex::Dependency.credit_card_finder
        @storefront_find_by_variant_finder = Aypex::Dependency.line_item_by_variant_finder
        @storefront_products_finder = Aypex::Dependency.products_finder
        @storefront_category_finder = Aypex::Dependency.category_finder

        @error_handler = 'Aypex::Api::ErrorHandler'
      end

      def set_platform_defaults
        # serializers
        @platform_admin_user_serializer = 'Aypex::Api::V2::Platform::UserSerializer'

        # coupon code handler
        @platform_coupon_handler = Aypex::Dependency.coupon_handler

        # order services
        @platform_order_recalculate_service = Aypex::Dependency.cart_recalculate_service
        @platform_order_update_service = Aypex::Dependency.checkout_update_service
        @platform_order_empty_service = Aypex::Dependency.cart_empty_service
        @platform_order_destroy_service = Aypex::Dependency.cart_destroy_service
        @platform_order_next_service = Aypex::Dependency.checkout_next_service
        @platform_order_advance_service = Aypex::Dependency.checkout_advance_service
        @platform_order_complete_service = Aypex::Dependency.checkout_complete_service
        @platform_order_use_store_credit_service = Aypex::Dependency.checkout_add_store_credit_service
        @platform_order_remove_store_credit_service = Aypex::Dependency.checkout_remove_store_credit_service
        @platform_order_approve_service = Aypex::Dependency.order_approve_service
        @platform_order_cancel_service = Aypex::Dependency.order_cancel_service

        # line item services
        @platform_line_item_create_service = Aypex::Dependency.line_item_create_service
        @platform_line_item_update_service = Aypex::Dependency.line_item_update_service
        @platform_line_item_destroy_service = Aypex::Dependency.line_item_destroy_service

        # shipment services
        @platform_shipment_create_service = Aypex::Dependency.shipment_create_service
        @platform_shipment_update_service = Aypex::Dependency.shipment_update_service
        @platform_shipment_change_state_service = Aypex::Dependency.shipment_change_state_service
        @platform_shipment_add_item_service = Aypex::Dependency.shipment_add_item_service
        @platform_shipment_remove_item_service = Aypex::Dependency.shipment_remove_item_service
      end
    end
  end
end
