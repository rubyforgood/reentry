require 'test_helper'

describe ServiceNormalizer do
  let(:normalizer) { ServiceNormalizer }

  describe '.normalize' do
    describe 'with a single word' do
      it 'returns an array of one string' do
        services = 'Veterans'
        assert_equal ['Veterans'],
                     normalizer.normalize(services)
      end
    end

    describe 'with single 2-word phrase' do
      it 'returns an array of one string' do
        services = 'Support Services'
        assert_equal ['Support Services'],
                     normalizer.normalize(services)
      end
    end

    describe 'with phrases separated by ampersands' do
      it 'returns an array of strings' do
        services = 'Food & Housing'
        assert_equal ['Food', 'Housing'],
                     normalizer.normalize(services)
      end
    end

    {
      nil => [],
      'Education' => ['Education'],
      'food' => ['Food'],
      'Food & Housing' => ['Food', 'Housing'],
      'Housing' => ['Housing'],
      'Legal' => ['Legal'],
      'Multi' => [],
      'Support Group' => ['Support Groups'],
      'Support group' => ['Support Groups']
    }.each_pair do |input, output|
      it "converts #{input.inspect} to #{output.inspect}" do
        assert_equal output, normalizer.normalize(input)
      end
    end
  end
end
