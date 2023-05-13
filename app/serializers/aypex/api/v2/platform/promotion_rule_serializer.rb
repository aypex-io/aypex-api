module Aypex
  module Api
    module V2
      module Platform
        class PromotionRuleSerializer < BaseSerializer
          include ResourceSerializerConcern

          attribute :amount_min, if: proc { |record| record.respond_to?(:amount_min) } do |object|
            object.amount_min
          end
          attribute :amount_max, if: proc { |record| record.respond_to?(:amount_max) } do |object|
            object.amount_max
          end
          attribute :country_id, if: proc { |record| record.respond_to?(:country_id) } do |object|
            object.country_id
          end
          attribute :eligible_values, if: proc { |record| record.respond_to?(:eligible_values) } do |object|
            object.eligible_values
          end
          attribute :match_policy, if: proc { |record| record.respond_to?(:match_policy) } do |object|
            object.match_policy
          end
          attribute :operator_min, if: proc { |record| record.respond_to?(:operator_min) } do |object|
            object.operator_min
          end
          attribute :operator_max, if: proc { |record| record.respond_to?(:operator_max) } do |object|
            object.operator_max
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
