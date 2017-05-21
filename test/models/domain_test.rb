require 'test_helper'

describe Domain do
  class MockProcessor
    def perform(id); end
  end

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

  describe '#perform_processor' do
    it 'sets the searched_at timestamp' do
      domain = Domain.create(kind: 'DOJProcessor')
      assert_nil domain.searched_at

      DOJProcessor.stub(:new, MockProcessor.new) do
        domain.perform_processor
      end

      refute_nil domain.searched_at
    end
  end
end
