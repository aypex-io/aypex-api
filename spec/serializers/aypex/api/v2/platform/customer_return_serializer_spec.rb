require "spec_helper"

describe Aypex::Api::V2::Platform::CustomerReturnSerializer do
  include_context "API v2 serializers params"

  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :customer_return }
  let(:resource) { create(:customer_return) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {
            self: "http://#{store.url}/api/v2/platform/#{type.to_s.pluralize}/#{resource.id}"
          },
          attributes: {
            display_pre_tax_total: resource.display_pre_tax_total.to_s,
            number: resource.number,
            private_metadata: {},
            public_metadata: {},
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            reimbursements: {
              data: []
            },
            return_authorizations: {
              data: [
                {
                  id: resource.return_authorizations.first.id.to_s,
                  type: :return_authorization
                }
              ]
            },
            return_items: {
              data: [
                {
                  id: resource.return_items.first.id.to_s,
                  type: :return_item
                }
              ]
            },
            stock_location: {
              data: {
                id: resource.stock_location.id.to_s,
                type: :stock_location
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
