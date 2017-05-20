require "test_helper"

describe PhoneNumber do
  let(:phone_number) { PhoneNumber.new }

  it "must be valid" do
    value(phone_number).must_be :valid?
  end
end
