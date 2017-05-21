require 'test_helper'

describe Domain do
  it 'must be valid' do
    assert_equal true, Domain.new.valid?
  end

  describe '#services' do
    it 'returns an array' do
      assert_equal [], Domain.create.services.to_a
    end

    it 'returns a collection of Service' do
      service = Service.create
      domain = Domain.create
      domain.services << service
      assert domain.services.include?(service)
    end
  end
end
