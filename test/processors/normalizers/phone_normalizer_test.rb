require 'test_helper'

describe PhoneNormalizer do
  let(:normalizer) { PhoneNormalizer }

  describe '.normalize' do
    describe "with a string containing two phone numbers split by a '/'" do
      it 'returns an array containing both PhoneNumbers' do
        numbers = '(222) 837-^M1800 ext.^M240 / (410)^M887-0295'
        result = normalizer.normalize numbers
        number_1 = result.first
        number_2 = result.last

        assert_equal 2, result.length
        assert_equal '222-837-1800 ext: 240', number_1
        assert_equal '410-887-0295', number_2
      end
    end

    describe "with a string containing two phone numbers split by a ';'" do
      it 'returns an array containing both PhoneNumbers' do
        numbers = '(410) 837-^M1800 ext.^M240 ; (410)^M887-0295'
        result = normalizer.normalize numbers
        number_1 = result.first
        number_2 = result.last

        assert_equal 2, result.length
        assert_equal '410-837-1800 ext: 240', number_1
        assert_equal '410-887-0295', number_2
      end
    end

    describe 'with a string containing non digit characters' do
      describe 'and a 10 digit phone number' do
        it 'returns an array containing the normalized 10 digit PhoneNumber' do
          number       = '(234). 567-^M8910'
          result       = normalizer.normalize number
          phone_number = result.first

          assert_instance_of Array, result
          assert_equal '234-567-8910', phone_number
        end
      end

      describe 'and a 9 digit phone number' do
        it 'returns an array containing the normalized 9 digit PhoneNumber' do
          number       = '1 (234). 567-^M8910'
          result       = normalizer.normalize number
          phone_number = result.first

          assert_instance_of Array, result
          assert_equal '1-234-567-8910', phone_number
        end
      end

      describe 'and an alphanumeric phone number' do
        it 'returns an array containing the alphanumeric PhoneNumber' do
          number       = '(202) 810-HOPE (4673)'
          result       = normalizer.normalize number
          phone_number = result.first

          assert_instance_of Array, result
          assert_equal '202-810-HOPE (4673)', phone_number
        end
      end
    end

    describe 'with an extension' do
      it 'returns an array containing the normalized PhoneNumber with an extension' do
        number_1            = '234.567.8910 ext 91233'
        number_2            = '(234)567-8910 ext 91233'
        number_3            = '1-[234]-567-8910 ext. 91233'

        normalized_number_1 = normalizer.normalize(number_1).first
        normalized_number_2 = normalizer.normalize(number_2).first
        normalized_number_3 = normalizer.normalize(number_3).first

        assert_equal '234-567-8910 ext: 91233', normalized_number_1
        assert_equal '234-567-8910 ext: 91233', normalized_number_2
        assert_equal '1-234-567-8910 ext: 91233', normalized_number_3
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

        assert_equal invalid_number_format, unnormalized_number.first
      end
    end
  end
end
