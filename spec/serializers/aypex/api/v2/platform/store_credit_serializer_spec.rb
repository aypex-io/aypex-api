require "spec_helper"

describe Aypex::Api::V2::Platform::StoreCreditSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :store_credit }
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
            amount: resource.amount,
            amount_authorized: resource.amount_authorized,
            amount_used: resource.amount_used,
            created_at: resource.created_at,
            currency: resource.currency,
            deleted_at: resource.deleted_at,
            display_amount: resource.display_amount.to_s,
            display_amount_used: resource.display_amount_used.to_s,
            memo: resource.memo,
            originator_type: resource.originator_type,
            private_metadata: {},
            public_metadata: {},
            updated_at: resource.updated_at
          },
          relationships: {
            created_by: {
              data: {
                id: resource.created_by.id.to_s,
                type: :user
              }
            },
            store_credit_category: {
              data: {
                id: resource.category.id.to_s,
                type: :store_credit_category
              }
            },
            store_credit_events: {
              data: [
                {
                  id: resource.store_credit_events.first.id.to_s,
                  type: :store_credit_event
                }
              ]
            },
            store_credit_type: {
              data: {
                id: resource.credit_type.id.to_s,
                type: :store_credit_type
              }
            },
            user: {
              data: {
                id: resource.user.id.to_s,
                type: :user
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
