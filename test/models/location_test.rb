require "test_helper"

describe Location do
  it 'must be valid' do
    assert_equal true, Location.new(domain: Domain.new).valid?
  end
end
