require "spec_helper"

module Aypex
  describe LegacyUser, type: :model do
    let(:user) { LegacyUser.new }

    it "can generate an API key" do
      expect(user).to receive(:save!)
      user.generate_aypex_api_key!
      expect(user.aypex_api_key).not_to be_blank
    end

    it "can clear an API key" do
      expect(user).to receive(:save!)
      user.clear_aypex_api_key!
      expect(user.aypex_api_key).to be_blank
    end
  end
end
