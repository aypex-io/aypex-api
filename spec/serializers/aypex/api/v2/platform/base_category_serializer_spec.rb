require 'spec_helper'

describe Aypex::Api::V2::Platform::BaseCategorySerializer, retry: 3 do
  subject { described_class.new(base_category).serializable_hash }

  let(:base_category) { create(:base_category) }
  let(:category) { create(:category, base_category: base_category) }
  let(:categories_json) do
    base_category.categories.map do |category|
      {
        id: category.id.to_s,
        type: :category
      }
    end
  end

  it { expect(subject).to be_kind_of(Hash) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: base_category.id.to_s,
          type: :base_category,
          attributes: {
            name: base_category.name,
            created_at: base_category.created_at,
            updated_at: base_category.updated_at,
            position: base_category.position,
            public_metadata: {},
            private_metadata: {}
          },
          relationships: {
            root: {
              data: {
                id: base_category.root.id.to_s,
                type: :category
              }
            },
            categories: {
              data: categories_json
            }
          }
        }
      }
    )
  end

  it_behaves_like 'an ActiveJob serializable hash'
end
