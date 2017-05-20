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
      VCR.use_cassette('doj_pdf_fetcher') do
        domain.perform_processor
      end

      relation = Location
                 .where(domain: domain)
                 .where.not(name: nil)
                 .order(:name)

      assert_equal 'AAMC Community Health Center',
                   relation.first.name

      assert_equal 'Youth Empowered Society (YES) Drop- In Center',
                   relation.last(2).first.name
    end
  end
end
