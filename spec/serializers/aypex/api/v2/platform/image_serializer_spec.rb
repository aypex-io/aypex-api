require "spec_helper"

describe Aypex::Api::V2::Platform::ImageSerializer do
  subject { described_class.new(image) }

  let(:product) { create(:product) }
  let(:image) { create(:image, viewable: product) }

  it { expect(subject.serializable_hash).to be_kind_of(Hash) }

  it do
    expect(subject.serializable_hash).to eq(
      {
        data: {
          id: image.id.to_s,
          type: :image,
          attributes: {
            position: image.position,
            alt: image.alt,
            created_at: image.created_at,
            updated_at: image.updated_at,
            transformed_url: nil,
            original_url: image.original_url
          },
          relationships: {
            viewable: {
              data: {
                id: product.id.to_s,
                type: :product
              }
            }
          }
        }
      }
    )
  end
end
