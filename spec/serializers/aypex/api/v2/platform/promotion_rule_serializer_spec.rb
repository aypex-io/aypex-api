require "spec_helper"

describe Aypex::Api::V2::Platform::PromotionRuleSerializer do
  include_context "API v2 serializers params"

  subject { described_class.new(resource, params: serializer_params) }

  let(:resource) { create(:promotion_rule) }

  it { expect(subject.serializable_hash).to be_kind_of(Hash) }
end
