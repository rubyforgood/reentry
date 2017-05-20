require 'test_helper'

class DOJProcessorTest < ActiveSupport::TestCase
  let(:domain) do
    Domain.create(
      kind: 'DOJProcessor',
      url: 'https://www.justice.gov/usao-md/page/file/941351/download'
    )
  end

  describe '#perform' do
    it 'transforms and loads data from the DOJ PDF URL' do
      skip('This test is slower') if ENV['TEST_FASTER']

      VCR.use_cassette('doj_pdf_fetcher') do
        domain.perform_processor
      end

      names = Location
              .where(domain: domain)
              .where.not(name: nil)
              .select(:name)
              .map(&:name)
              .sort
              .reject(&:empty?)

      assert_equal '* Crisis Hotline',
                   names.first

      assert_equal 'Youth Empowered Society (YES) Drop- In Center',
                   names.last
    end
  end
end
