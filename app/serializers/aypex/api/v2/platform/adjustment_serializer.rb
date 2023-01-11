module Aypex
  module Api
    module V2
      module Platform
        class AdjustmentSerializer < BaseSerializer
          include ResourceSerializerConcern

          belongs_to :order
          belongs_to :adjustable, polymorphic: true
          belongs_to :source, polymorphic: {
            Aypex::Promotion::Actions::FreeShipping => :promotion_action,
            Aypex::Promotion::Actions::CreateItemAdjustments => :promotion_action,
            Aypex::Promotion::Actions::CreateLineItems => :promotion_action
          }
        end
      end
    end
  end
end
