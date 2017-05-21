require "test_helper"

describe Location do
  it 'must be valid' do
    assert_equal true, Location.new(domain: Domain.new).valid?
  end

  describe '#services' do
    it 'returns an array' do
      assert_equal [], Location.create.services.to_a
    end

    it 'returns a collection of Service' do
      service = Service.create
      location = Location.create(domain: Domain.new)
      location.services << service
      assert location.services.include?(service)
    end
  end
end
