require "spec_helper"

describe Aypex::Api::V2::Platform::ReimbursementCreditSerializer do
  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  include_context "API v2 serializers params"

  let(:type) { :reimbursement_credit }
  let(:resource) { create(type, creditable: create(:store_credit)) }

  it do
    expect(subject).to eq(
      {
        data: {
          id: resource.id.to_s,
          type: type
        }
      }
    )
  end

  it_behaves_like "an ActiveJob serializable hash"
end
