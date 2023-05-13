module Aypex
  module Api
    module V2
      module Platform
        class CalculatorSerializer < BaseSerializer
          include ResourceSerializerConcern

          attributes :type

          attribute :additional_item, if: proc { |record| record.respond_to?(:additional_item) } do |object|
            object.additional_item
          end
          attribute :amount, if: proc { |record| record.respond_to?(:amount) } do |object|
            object.amount
          end
          attribute :currency, if: proc { |record| record.respond_to?(:currency) } do |object|
            object.currency
          end
          attribute :discount_amount, if: proc { |record| record.respond_to?(:discount_amount) } do |object|
            object.discount_amount
          end
          attribute :first_item, if: proc { |record| record.respond_to?(:first_item) } do |object|
            object.first_item
          end
          attribute :flat_percent, if: proc { |record| record.respond_to?(:flat_percent) } do |object|
            object.flat_percent
          end
          attribute :max_items, if: proc { |record| record.respond_to?(:max_items) } do |object|
            object.max_items
          end
          attribute :minimal_amount, if: proc { |record| record.respond_to?(:minimal_amount) } do |object|
            object.minimal_amount
          end
          attribute :normal_amount, if: proc { |record| record.respond_to?(:normal_amount) } do |object|
            object.normal_amount
          end
          attribute :percent, if: proc { |record| record.respond_to?(:percent) } do |object|
            object.percent
          end
        end
      end
    end
  end
end
