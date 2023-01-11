module Aypex
  module Api
    module V2
      module Platform
        class CmsSectionsController < ResourceController
          private

          def model_class
            Aypex::CmsSection
          end

          def aypex_permitted_attributes
            stored_attributes = []

            Aypex::CmsSection::TYPES.each do |type|
              type.constantize.stored_attributes.each do |_name, values|
                values.each do |value|
                  stored_attributes << value
                end
              end
            end

            super + stored_attributes.compact.uniq!
          end
        end
      end
    end
  end
end
