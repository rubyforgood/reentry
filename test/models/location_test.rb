require "test_helper"

describe Location do
  it 'must be valid' do
    assert_equal true, Location.new(domain: Domain.new).valid?
  end

  describe '#services' do
    it 'returns an array' do
      skip "services is both a columns and an association currently"
      assert_equal [], Location.create.services.to_a
    end

    it 'returns a collection of Service' do
      skip "services is both a column and an association currently"
      service = Service.create
      location = Location.create(domain: Domain.new)
      location.services << service
      assert location.services.include?(service)
    end
  end
end
