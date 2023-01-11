module Aypex
  module Api
    module V2
      module Platform
        class WishlistsController < ResourceController
          private

          def model_class
            Aypex::Wishlist
          end

          def scope_includes
            [:wished_items]
          end
        end
      end
    end
  end
end
