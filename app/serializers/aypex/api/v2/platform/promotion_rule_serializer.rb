module Aypex
  module Api
    module V2
      module Platform
        class PromotionRuleSerializer < BaseSerializer
          include ResourceSerializerConcern

          attribute :settings do |promotion_rule|
            promotion_rule.settings
          end

          belongs_to :promotion

          has_many :products, through: :product_promotion_rules, if: proc { |record| record.respond_to?(:product_promotion_rules) }
          has_many :users, through: :promotion_rule_users, if: proc { |record| record.respond_to?(:promotion_rule_users) }
          has_many :categories, through: :promotion_rule_categories, if: proc { |record| record.respond_to?(:promotion_rule_categories) }
        end
      end
    end
  end
end
