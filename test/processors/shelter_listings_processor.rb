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
      end 

      it '.get_list_of_detail_links returns an ary of detail links' do 
      end 

      it '.extract_data_from_details_page returns a data hash' do
      end

      it '.extract_data_from_details_page returns a data hash' do
      end

      describe '.store_location' do 
        it '.extract_shelterlistings_address extracts an address' do 
        end

        it '.store_location create a location record' do 
        end 
      end

    end

  end


end
