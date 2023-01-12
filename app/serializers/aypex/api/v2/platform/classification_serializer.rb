module Aypex
  module Api
    module V2
      module Platform
        class ClassificationSerializer < BaseSerializer
          include ResourceSerializerConcern

          belongs_to :product
          belongs_to :category
        end
      end
    end
  end
end
