require 'test_helper'
require 'open-uri'
require 'nokogiri'

class ShelterListingsSpiderTest < ActiveSupport::TestCase
  myUrl = 'http://www.shelterlistings.org/details/38685/'
  
  def doc
    @doc ||= VCR.use_cassette("shelter listings spider") do
      Nokogiri::HTML(open(myUrl))
    end
  end

  test "Run extract_shelterlistings_address within shelter_listings_spider" do
    slist = ShelterListingsSpider.new
    assert slist.run
  end

  test "Return Maryland address from extract_shelterlistings_address method" do
    expected = "3104 Pelham Avenue Belair - Edison Baltimore Maryland United States 21213 1745"

    slist = ShelterListingsSpider.new
    address = slist.send :extract_shelterlistings_address, doc
    outcome = address.data["address_components"].map do |hash|
      hash["long_name"]
    end.join(" ")

    assert_equal outcome, expected
    #binding.pry

  end
end


 # @data=
 #  {"address_components"=>
 #    [{"long_name"=>"3104", "short_name"=>"3104", "types"=>["street_number"]},
 #     {"long_name"=>"Pelham Avenue", "short_name"=>"Pelham Ave", "types"=>["route"]},
 #     {"long_name"=>"Belair - Edison", "short_name"=>"Belair - Edison", "types"=>["neighborhood", "political"]},
 #     {"long_name"=>"Baltimore", "short_name"=>"Baltimore", "types"=>["locality", "political"]},
 #     {"long_name"=>"Maryland", "short_name"=>"MD", "types"=>["administrative_area_level_1", "political"]},
 #     {"long_name"=>"United States", "short_name"=>"US", "types"=>["country", "political"]},
 #     {"long_name"=>"21213", "short_name"=>"21213", "types"=>["postal_code"]},
 #     {"long_name"=>"1745", "short_name"=>"1745", "types"=>["postal_code_suffix"]}],
 #   "formatted_address"=>"3104 Pelham Ave, Baltimore, MD 21213, USA",
 #   "geometry"=>
 #    {"location"=>{"lat"=>39.323683, "lng"=>-76.569064},
 #     "location_type"=>"ROOFTOP",
 #     "viewport"=>
 #      {"northeast"=>{"lat"=>39.3250319802915, "lng"=>-76.56771501970849},
 #       "southwest"=>{"lat"=>39.3223340197085, "lng"=>-76.57041298029151}}},