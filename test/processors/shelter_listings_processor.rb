require 'test_helper'

class ShelterListingsProcessorTest < ActiveSupport::TestCase
  let(:state_domain) do
    Domain.create(
      url: 'http://www.shelterlistings.org/state/maryland.html'
    )
  end
  let(:details_page_url) {'http://www.shelterlistings.org/details/31018/'}
  
  describe '.perform' do
    describe '.run_shelter_listings_spider' do

      it '.get_list_of_cities returns an ary of city tags' do 
        VCR.use_cassette('shelter_listings_MD_html') do
          list_of_cities = ShelterListingsProcessor.new.get_list_of_cities(url: state_domain.url)
          assert list_of_cities.is_a? Array
        end
      end 

      it '.get_list_of_detail_links returns an ary of detail links' do 
        VCR.use_cassette('shelter_listings_details_html') do
          list_of_links = ShelterListingsProcessor.new.get_list_of_detail_links(links_array: [details_page_url])
          assert list_of_links.is_a? Array
        end
      end 

      it '.extract_data_from_details_page returns a data hash' do
        VCR.use_cassette('shelter_listings_details_html') do
          data_hash = ShelterListingsProcessor.new.extract_data_from_details_page(details_url: details_page_url)
          assert data_hash.is_a? Hash
        end
      end

      it '.extract_shelterlistings_address returns an address hash' do
        expected_addr = "53 E Bel Air Ave, Aberdeen, MD 21001, USA"
        expected_lat = 40
        expected_lng = -76

        VCR.use_cassette("shelter listings spider") do
          data_hash = ShelterListingsProcessor.new.extract_data_from_details_page(details_url: details_page_url)
          assert data_hash.is_a? Hash
          assert_equal data_hash[:address], expected_addr
          assert_equal data_hash[:latitude].round, expected_lat
          assert_equal data_hash[:longitude].round, expected_lng
        end
      
      end
    end

  end
end

