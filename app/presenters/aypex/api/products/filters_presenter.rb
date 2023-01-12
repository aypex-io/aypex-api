module Aypex
  module Api
    module Products
      class FiltersPresenter
        def initialize(current_store, current_currency, params)
          @products_for_filters = find_products_for_filters(current_store, current_currency, params)
        end

        def to_h
          option_values = Aypex::OptionValues::FindAvailable.new(products_scope: products_for_filters).execute
          option_values_presenters = Aypex::Filters::OptionsPresenter.new(option_values_scope: option_values).to_a
          product_properties = Aypex::ProductProperties::FindAvailable.new(products_scope: products_for_filters).execute
          product_properties_presenters = Aypex::Filters::PropertiesPresenter.new(product_properties_scope: product_properties).to_a
          {
            option_types: option_values_presenters.map(&:to_h),
            product_properties: product_properties_presenters.map(&:to_h)
          }
        end

        private

        attr_reader :products_for_filters

        def find_products_for_filters(current_store, current_currency, params)
          current_categories = find_current_categories(current_store, params)
          current_store.products.active(current_currency).in_categories(current_categories)
        end

        def find_current_categories(current_store, params)
          categories_param = params.dig(:filter, :categories)
          return nil if categories_param.nil? || categories_param.to_s.blank?

          category_ids = categories_param.to_s.split(",")
          current_store.categories.where(id: category_ids)
        end
      end
    end
  end
end
