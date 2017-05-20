require 'test_helper'

describe PhoneNormalizer do
  let(:normalizer) { PhoneNormalizer }

  describe '.normalize' do
    describe 'with a string containing two numbers' do
      it 'returns a string in the XXX-XXX-XXXX format' do
        numbers = '(410) 837-^M1800 ext.^M240 / (410)^M887-0295'
        result = normalizer.normalize numbers
        number_1 = result.first
        number_2 = result.last

        assert_equal 2, result.length
        assert_equal '410-837-1800 ext: 240', number_1.number
        assert_equal '410-887-0295', number_2.number
      end
    end

    describe 'with a string in the (XXX) XXX-^MXXX format' do
      it 'returns an array containing the normalized PhoneNumber' do
        number       = '(234) 567-^M8910'
        result       = normalizer.normalize number
        phone_number = result.first

        assert_instance_of Array, result
        assert_equal '234-567-8910', phone_number.number
      end
    end

    describe 'with a string in the X-XXX-XXX-XXXX format' do
      it 'returns an array containing the normalized PhoneNumber' do
        number = '1-234-567-8910'
        result = normalizer.normalize(number).first

        assert_equal '1-234-567-8910', result.number
      end
    end

    describe 'with a string in the XXX-XXX-XXXX format' do
      it 'returns an array containing the normalized PhoneNumber' do
        number = '234-567-8910'
        result = normalizer.normalize(number).first

        assert_equal '234-567-8910', result.number
      end
    end

    describe 'with a string in the (XXX)XXX-XXXX format' do
      it 'returns an array containing the normalized PhoneNumber' do
        number = '(234)567-8910'
        result = normalizer.normalize(number).first

        assert_equal '234-567-8910', result.number
      end
    end

    describe 'with a string in the XXX.XXX.XXXX format' do
      it 'returns an array containing the normalized PhoneNumber' do
        number = '234.567.8910'
        result = normalizer.normalize(number).first

        assert_equal '234-567-8910', result.number
      end
    end

    describe 'with an extension' do
      it 'returns an array containing the normalized PhoneNumber with an extension' do
        number_1            = '234.567.8910 x91233'
        number_2            = '(234)567-8910 x91233'
        number_3            = '1-234-567-8910 x91233'

        normalized_number_1 = normalizer.normalize(number_1).first
        normalized_number_2 = normalizer.normalize(number_2).first
        normalized_number_3 = normalizer.normalize(number_3).first

        assert_equal '234-567-8910 ext: 91233', normalized_number_1.number
        assert_equal '234-567-8910 ext: 91233', normalized_number_2.number
        assert_equal '1-234-567-8910 ext: 91233', normalized_number_3.number
      end
    end

    describe 'with an invalid phone number format' do
      it 'logs the phone number and returns the original input' do
        invalid_number_format = 'Call 211'
        logged_message        = 'Unhandled phone number format received: Call 211'

        Rails.logger
          .expects(:warn)
          .returns(logged_message)

        normalizer.normalize invalid_number_format
      end

      it 'returns the original input ' do
        invalid_number_format = 'Call 211'
        unnormalized_number   = normalizer.normalize invalid_number_format

        assert_equal invalid_number_format, unnormalized_number.first.number
      end
    end
  end
end
