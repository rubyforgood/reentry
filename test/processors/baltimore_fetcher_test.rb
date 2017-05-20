require 'test_helper'

class BaltimoreFetcherTest < ActiveSupport::TestCase
  let (:fetcher) do
    domain = Domain.create(
      url: 'https://data.baltimorecity.gov/resource/4adc-a5y9.json'
    )
    BaltimoreFetcher.new(domain)
  end

  before do
    VCR.use_cassette('baltimore_json_fetcher') do
      fetcher.fetch
    end
  end

  it 'retrieves data from the Baltimore Homeless Services URL' do
    names = fetcher.records.map {|record| record[:name]}
    assert names.include?("Paul's Place")
  end

  it 'concatentates the address data' do
    addresses = fetcher.records.map {|record| record[:address]}
    assert addresses.any?, "Addresses are missing"
    assert addresses.include?("725 Fallsway, Baltimore, MD"), "Addresses are in the wrong format"
  end
end
