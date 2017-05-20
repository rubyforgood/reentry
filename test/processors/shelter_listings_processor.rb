require 'test_helper'

class ShelterListingsProcessorTest < ActiveSupport::TestCase
  let(:state_domain) do
    Domain.create(
      url: 'http://www.shelterlistings.org/state/maryland.html'
    )
  end

  let(:details_page_url) {'http://www.shelterlistings.org/details/31018/'}
  

  let(:shelter_listings_MD_page) do 
    VCR.use_cassette("shelter_listings_MD_html") do 
      assert PerformSpider.get_website_html(url: state_domain.url)
    end
  end

  let(:shelter_listings_detail_page) do 
    VCR.use_cassette("shelter_listings_details_page_html") do 
      assert PerformSpider.get_website_html(url: details_page_url)
    end
  end

  describe '.get_list_of_cities' do 
    links_ary = 
    get_list_of_detail_links(links_array: links_ary)
  #   cities_list = get_list_of_cities(url: domain_url)
  #   details_links = get_list_of_detail_links(links_array: cities_list)
  #   details_links.each do |link| 
  #     data_hash = extract_data_from_details_page(details_url:link)
  #     loc = store_location(location_data_hash: data_hash)
  #     Rails.logger.info "stored location" if loc
  #   end
  end
end
