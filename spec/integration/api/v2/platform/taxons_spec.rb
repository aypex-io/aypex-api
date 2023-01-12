require 'swagger_helper'

describe 'Categories API', swagger: true do
  include_context 'Platform API v2'

  resource_name = 'Category'
  options = {
    include_example: 'base_category,parent,children',
    filter_examples: [{ name: 'filter[base_category_id_eq]', example: '1' },
                      { name: 'filter[name_cont]', example: 'Shirts' }]
  }

  let(:base_category) { create(:base_category, store: store) }
  let(:id) { create(:category, base_category: base_category).id }

  let!(:category_b) { create(:category, name: 'Shorts', base_category: base_category) }

  let(:records_list) { create_list(:category, 2, base_category: base_category) }
  let(:valid_create_param_value) { build(:category, base_category: base_category).attributes }
  let(:valid_update_param_value) do
    {
      name: 'T-Shirts',
      public_metadata: { 'profitability' => 3 }
    }
  end
  let(:invalid_param_value) do
    {
      name: '',
    }
  end
  let(:valid_update_position_param_value) do
    {
      category: {
        new_parent_id: category_b.id,
        new_position_idx: 0
      }
    }
  end

  include_examples 'CRUD examples', resource_name, options

  path '/api/v2/platform/categories/{id}/reposition' do
    patch 'Reposition a Category' do
      tags resource_name.pluralize
      security [ bearer_auth: [] ]
      operationId 'reposition-category'
      description 'Reposition a Category'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :category, in: :body, schema: { '$ref' => '#/components/schemas/category_reposition' }

      let(:category) { valid_update_position_param_value }

      it_behaves_like 'record updated'
      it_behaves_like 'record not found', :category
      it_behaves_like 'authentication failed'
    end
  end
end
