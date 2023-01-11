module Aypex
  module Api::V2
    module Storefront
      class TaxonImageSerializer < BaseSerializer
        include ::Aypex::Api::V2::TaxonImageTransformationConcern

        set_type   :taxon_image

        attributes :styles, :alt, :original_url
      end
    end
  end
end
