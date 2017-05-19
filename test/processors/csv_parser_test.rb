require 'test_helper'

class CSVParserTest < ActiveSupport::TestCase
  let(:parser) { CSVParser }
  let(:sample_csv) { Rails.root + 'test/fixtures/files/doj-data.csv' }

  describe '.parse' do
    describe 'with csv file containing the correct headers' do
      it 'returns an array of hashes' do
        parsed_array = parser.parse(sample_csv)

        assert_instance_of Array, parsed_array
        assert_instance_of Hash, parsed_array.first
      end

      it 'does not return header rows' do
        parsed_array = parser.parse(sample_csv)
        county_columns = parsed_array.map { |row| row[:county] }

        refute_includes county_columns, 'County'
      end
    end

    describe 'with csv file containing incorrect headers' do
      it 'returns an error' do
        error_file = Rails.root + 'test/fixtures/files/error-data.csv'

        assert_raise Errors::UnprocessableEntity do
          parser.parse(error_file)
        end
      end
    end
  end
end
