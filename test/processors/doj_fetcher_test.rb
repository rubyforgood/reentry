require 'test_helper'

class DOJFetcherTest < ActiveSupport::TestCase
  let(:fetcher) { DOJFetcher }

  let(:domain) {
    Domain.create(
      url: 'https://www.justice.gov/usao-md/page/file/941351/download'
    )
  }

  describe '.fetch' do
    it 'retrieves data from the DOJ PDF URL' do
      csv_file = Rails.root + 'test/fixtures/files/doj-data.csv'
      expected = File.read(csv_file)

      VCR.use_cassette('doj_pdf_fetcher') do
        observed = File.read(fetcher.fetch(domain))
        assert_equal expected.lines, observed.lines
      end
    end
  end
end
