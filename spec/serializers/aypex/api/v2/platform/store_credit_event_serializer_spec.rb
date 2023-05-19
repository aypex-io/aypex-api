require "spec_helper"

describe Aypex::Api::V2::Platform::StoreCreditEventSerializer do
  include_context "API v2 serializers params"
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:type) { :store_credit_event }
  let(:resource) { create(:store_credit_auth_event) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type,
          links: {}, # TODO: Endpoint to add.
          attributes: {
            action: resource.action,
            amount: resource.amount,
            authorization_code: resource.authorization_code,
            deleted_at: resource.deleted_at,
            display_action: resource.display_action,
            display_amount: resource.display_amount.to_s,
            display_user_total_amount: resource.display_user_total_amount.to_s,
            originator_type: resource.originator_type,
            user_total_amount: resource.user_total_amount,
            created_at: resource.created_at,
            updated_at: resource.updated_at
          },
          relationships: {
            originator: {
              data: nil
            },
            store_credit: {
              data: {
                id: resource.store_credit.id.to_s,
                type: :store_credit
              }
            }
          }
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
