require 'test_helper'
require 'open-uri'
require 'nokogiri'

describe ShelterListingsProcessor do
  MyUrl = 'http://www.shelterlistings.org/details/38685/'
  let(:domain) do
    Domain.create(
      url: 'http://www.shelterlistings.org/state/maryland.html'
    )
  end

  it "Run extract_shelterlistings_address within shelter_listings_spider" do
    skip if ENV['TEST_FASTER']
    slist = ShelterListingsProcessor.new
    VCR.use_cassette("shelter listings spider") do
      assert slist.perform(domain.id)
    end
  end

  it "Return Maryland address from extract_shelterlistings_address method" do
    skip "Fix me, please. NoMethodError: undefined method data' for <Hash:0x007ff9c95d60b8>"
    expected = "3104 Pelham Avenue Belair - Edison Baltimore Maryland United States 21213 1745"

    slist = ShelterListingsProcessor.new

    VCR.use_cassette("shelter listings spider") do
      doc = Nokogiri::HTML(open(MyUrl))
      address = slist.send :extract_shelterlistings_address, doc
      outcome = address.data["address_components"].map do |hash|
        hash["long_name"]
      end.join(" ")
      assert_equal outcome, expected
    end
  end
end
