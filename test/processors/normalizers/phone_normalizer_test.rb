require 'test_helper'

describe PhoneNormalizer do
  let(:normalizer) { PhoneNormalizer }

  describe '.normalize' do
    describe 'with a string in the (XXX) XXX-^MXXX format' do
      it 'returns a string in the XXX-XXX-XXXX format' do
        number = '(234) 567-^M8910'
        normalized_number = normalizer.normalize number

        assert_equal '234-567-8910', normalized_number
      end
    end

    describe 'with a string in the X-XXX-XXX-XXXX format' do
      it 'returns a string in the X-XXX-XXX-XXXX format' do
        number            = '1-234-567-8910'
        normalized_number = normalizer.normalize number

        assert_equal '1-234-567-8910', normalized_number
      end
    end

    describe 'with a string in the XXX-XXX-XXXX format' do
      it 'returns a string in the XXX-XXX-XXXX format' do
        number            = '234-567-8910'
        normalized_number = normalizer.normalize number

        assert_equal '234-567-8910', normalized_number
      end
    end


    describe 'with a string in the (XXX)XXX-XXXX format' do
      it 'returns a string in the XXX-XXX-XXXX format' do
        number            = '(234)567-8910'
        normalized_number = normalizer.normalize number

        assert_equal '234-567-8910', normalized_number
      end
    end

    describe 'with a string in the XXX.XXX.XXXX format' do
      it 'returns a string in the XXX-XXX-XXXX format' do
        number            = '234.567.8910'
        normalized_number = normalizer.normalize number

        assert_equal '234-567-8910', normalized_number
      end
    end

    describe 'with an extension' do
      it 'returns a string in the correct format with an extension' do
        number_1            = '234.567.8910 x91233'
        number_2            = '(234)567-8910 x91233'
        number_3            = '1-234-567-8910 x91233'

        normalized_number_1 = normalizer.normalize number_1
        normalized_number_2 = normalizer.normalize number_2
        normalized_number_3 = normalizer.normalize number_3

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

      it 'returns the original input' do
        invalid_number_format = 'Call 211'
        unnormalized_number   = normalizer.normalize invalid_number_format

        assert_equal invalid_number_format, unnormalized_number
      end
    end
  end
end
