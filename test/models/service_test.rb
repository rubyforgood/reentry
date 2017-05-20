require "test_helper"

describe Service do
  let(:service) { Service.new }

  it "must be valid" do
    value(service).must_be :valid?
  end
end
