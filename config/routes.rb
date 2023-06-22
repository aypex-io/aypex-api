aypex_path = Rails.application.routes.url_helpers.try(:aypex_path, trailing_slash: true) || "/"

Rails.application.routes.draw do
  use_doorkeeper scope: "#{aypex_path}/aypex_oauth"
end

Aypex::Engine.routes.draw do
  namespace :api, defaults: {format: "json"} do
    namespace :v2 do
      namespace :storefront do
        resource :cart, controller: :cart, only: %i[show create destroy] do
          post :add_item
          patch :empty
          delete "remove_line_item/:line_item_id", to: "cart#remove_line_item", as: :cart_remove_line_item
          patch :set_quantity
          patch :apply_coupon_code
          delete "remove_coupon_code/:coupon_code", to: "cart#remove_coupon_code", as: :cart_remove_coupon_code
          delete "remove_coupon_code", to: "cart#remove_coupon_code", as: :cart_remove_coupon_code_without_code
          get :estimate_shipping_rates
          patch :associate
          patch :change_currency
        end

        resource :checkout, controller: :checkout, only: %i[update] do
          patch :next
          patch :advance
          patch :complete
          post :create_payment
          post :add_store_credit
          post :remove_store_credit
          get :payment_methods
          get :shipping_rates
          patch :select_shipping_method
        end

        resource :account, controller: :account, only: %i[show create update]

        namespace :account do
          resources :addresses, controller: :addresses
          resources :credit_cards, controller: :credit_cards, only: %i[index show destroy]
          resources :orders, controller: :orders, only: %i[index show]
        end

        resources :countries, only: %i[index]
        get "/countries/:iso", to: "countries#show", as: :country
        get "/order_status/:number", to: "order_status#show", as: :order_status
        resources :products, only: %i[index show]
        resources :categories, only: %i[index show], id: /.+/
        get "/stores/:code", to: "stores#show", as: :store
        get "/store", to: "stores#current", as: :current_store

        resources :menus, only: %i[index show]
        resources :cms_pages, only: %i[index show]

        resources :wishlists do
          get :default, on: :collection

          member do
            post :add_item
            patch "set_item_quantity/:item_id", to: "wishlists#set_item_quantity", as: :set_item_quantity
            delete "remove_item/:item_id", to: "wishlists#remove_item", as: :remove_item
          end
        end

        get "/digitals/:token", to: "digitals#download", as: "digital"
      end

      namespace :platform do
        # Promotions API
        resources :promotions, except: :new
        resources :promotion_actions, except: :new
        resources :promotion_categories, except: :new
        resources :promotion_rules, except: :new

        # Returns API
        resources :customer_returns, except: :new
        resources :reimbursements, except: :new
        resources :return_authorizations, except: :new do
          member do
            patch :add
            patch :cancel
            patch :receive
          end
        end

        # Product Catalog API
        resources :products, except: :new
        resources :base_categories, except: :new
        resources :categories, except: :new do
          member do
            patch :reposition
          end
        end
        resources :prices, except: :new
        resources :classifications, except: :new
        resources :images, except: :new
        resources :variants, except: :new
        resources :properties, except: :new
        resources :product_properties, except: :new
        resources :option_types, except: :new
        resources :option_values, except: :new

        # Order API
        resources :orders, except: :new do
          member do
            patch :next
            patch :advance
            patch :approve
            patch :cancel
            patch :empty
            patch :apply_coupon_code
            patch :complete
            patch :use_store_credit
            patch :cancel
            patch :approve
          end
        end
        resources :line_items, except: :new
        resources :adjustments, except: :new

        # Payments API
        resources :payments, except: :new do
          # TODO: support custom actions
          # member do
          #   patch :authorize
          #   patch :capture
          #   patch :purchase
          #   patch :void
          #   patch :credit
          # end
        end

        # Store Credit API
        resources :store_credits, except: :new
        resources :store_credit_categories, except: :new
        resources :store_credit_types, except: :new

        # Geo API
        resources :zones, except: :new
        resources :countries, only: [:index, :show]
        resources :states, only: [:index, :show]

        # Shipment API
        resources :shipments, except: :new do
          member do
            %w[ready ship cancel resume pend].each do |state|
              patch state.to_sym
            end
            patch :add_item
            patch :remove_item
            patch :transfer_to_location
            patch :transfer_to_shipment
          end
        end

        # Tax API
        resources :tax_rates, except: :new
        resources :tax_categories, except: :new

        # Inventory API
        resources :inventory_units, except: :new
        resources :stock_items, except: :new
        resources :stock_locations, except: :new
        resources :stock_movements, except: :new

        # User API
        resources :users, except: :new
        resources :credit_cards, except: :new
        resources :addresses, except: :new

        resources :roles, except: :new

        # Menu API
        resources :menus, except: :new
        resources :menu_items, except: :new do
          member do
            patch :reposition
          end
        end

        # CMS
        resources :cms_pages, except: :new
        resources :cms_sections, except: :new
        resources :cms_components, except: :new

        # Wishlists API
        resources :wishlists, except: :new
        resources :wished_items, except: :new

        # Digitals API
        resources :digitals, except: :new
        resources :digital_links, except: :new do
          member do
            patch :reset
          end
        end

        # Store API
        resources :stores, except: :new

        # Configurations API
        resources :payment_methods, except: :new
        resources :shipping_categories, except: :new
        resources :shipping_methods, except: :new

        # Webhooks API
        namespace :webhooks, except: :new do
          resources :events, only: :index
          resources :subscribers, only: :index
        end
      end
    end
  end
end
