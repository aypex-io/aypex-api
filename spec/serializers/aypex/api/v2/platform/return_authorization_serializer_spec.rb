require "spec_helper"

describe Aypex::Api::V2::Platform::ReturnAuthorizationSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :return_authorization }
  let(:resource) { create(type) }

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
            memo: resource.memo,
            number: resource.number,
            state: resource.state,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            order: {
              data: {
                id: resource.order.id.to_s,
                type: :order
              }
            },
            return_authorization_reason: {
              data: {
                id: resource.reason.id.to_s,
                type: :return_authorization_reason
              }
            },
            stock_location: {
              data: {
                id: resource.stock_location.id.to_s,
                type: :stock_location
              }
            },
            return_items: {
              data: []
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
