module Aypex
  class TestArgumentsJob < Aypex::BaseJob
    def perform(serializer)
    end
  end
end

shared_examples "an ActiveJob serializable hash" do
  it "can be serialized by ActiveJob" do
    # It should fail if subject contains any custom instance (e.g Aypex::Money)
    expect { Aypex::TestArgumentsJob.perform_later(subject) }.not_to raise_error
    expect { Aypex::TestArgumentsJob.perform_later(subject.merge(price: Aypex::Money.new(0))) }.to(
      raise_error(ActiveJob::SerializationError)
    )
  end
end
