require "spec_helper"

describe Aypex::Api::V2::Platform::RefundSerializer do
  include_context "API v2 serializers params"

  subject { described_class.new(resource, params: serializer_params).serializable_hash }

  let(:resource) { create(:refund, amount: 5.0) }

  it { expect(subject).to be_kind_of(Hash) }

  it_behaves_like "an ActiveJob serializable hash"
end
