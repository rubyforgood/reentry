# require 'test_helper'
# require 'open-uri'
# require 'nokogiri'
#
# class ShelterListingsSpiderTest < ActiveSupport::TestCase
#   MyUrl = 'http://www.shelterlistings.org/details/38685/'
#
#   test "Run extract_shelterlistings_address within shelter_listings_spider" do
#     slist = ShelterListingsSpider.new
#     VCR.use_cassette("shelter listings spider") do
#       assert slist.run
#     end
#   end
#
#   test "Return Maryland address from extract_shelterlistings_address method" do
#     expected = "3104 Pelham Avenue Belair - Edison Baltimore Maryland United States 21213 1745"
#
#     slist = ShelterListingsSpider.new
#
#     VCR.use_cassette("shelter listings spider") do
#       doc = Nokogiri::HTML(open(MyUrl))
#       address = slist.send :extract_shelterlistings_address, doc
#       outcome = address.data["address_components"].map do |hash|
#         hash["long_name"]
#       end.join(" ")
#       assert_equal outcome, expected
#     end
#   end
# end
