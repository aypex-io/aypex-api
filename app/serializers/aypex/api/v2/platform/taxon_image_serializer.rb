module Aypex
  module Api
    module V2
      module Platform
        class TaxonImageSerializer < BaseSerializer
          include ::Aypex::Api::V2::TaxonImageTransformationConcern

          set_type :taxon_image

          attributes :alt, :created_at, :updated_at, :original_url
        end
      end
    end
  end
end
