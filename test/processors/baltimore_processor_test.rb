require 'test_helper'

class BaltimoreProcessorTest < ActiveSupport::TestCase
  let(:domain) do
    Domain.create(
      kind: "BaltimoreProcessor",
      url: 'https://data.baltimorecity.gov/resource/4adc-a5y9.json'
    )
  end

  it "loads the data from the Baltimore API endpoint in to the database" do
    skip('This test is slower') if ENV['TEST_FASTER']
    VCR.use_cassette('baltimore_json_fetcher') do
      domain.perform_processor
    end
    relation = Location.where(domain: domain)
    assert relation.any?
    names = relation.map(&:name)
    refute names.include?(nil)
    assert names.include?("Paul's Place")
  end
end
