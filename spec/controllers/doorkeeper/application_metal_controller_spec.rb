require "spec_helper"

describe Doorkeeper::ApplicationMetalController, type: :controller do
  it "inherits from Aypex::Api::V2::BaseController" do
    expect(described_class.superclass).to eq Aypex::Api::V2::BaseController
  end
end
