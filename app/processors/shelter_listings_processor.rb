
class ShelterListingsProcessor < PerformSpider
	def perform(domain_id)
		domain = Domain.find(1)
		url = domain.url
		run_shelter_listings_spider(domain_url: url)
	end

	def run_shelter_listings_spider(domain_url: raise)
		cities_list = get_list_of_cities(url: domain_url)
		details_links = get_list_of_detail_links(links_array: cities_list)
		details_links.each do |link| 
			data_hash = extract_data_from_details_page(details_url:link)
			loc = store_location(location_data_hash: data_hash)
			Rails.logger.info "stored loc #{loc.id}"
		end
	end

	def get_list_of_cities(url: raise)
		city_links = []
		html_doc = get_website_html(url: url)
		
		link_tags = extract_data(html: html_doc, css_selectors: '.wrapper #content .post.page-content table a')

		link_tags.each {|tag| city_links << tag['href'] }
		city_links
	end

	def get_list_of_detail_links(links_array: raise)
		detail_links = []
		links_array.each do |link|
			html_doc = get_website_html(url: link)
			detail_links << extract_data(html: html_doc, css_selectors: 'table tr td a')[0]['href']
		end
		detail_links
	end

	def extract_data_from_details_page(details_url: raise)
		final_data = {}

		html_doc = get_website_html(url: details_url)
		final_data[:name] = extract_data(html: html_doc, css_selectors: '.post.page-content h2').children.first.text
		final_data[:address] = extract_data(html: html_doc, css_selectors: '.post.page-content br')[4].next.text.strip
		if extract_data(html: html_doc, css_selectors: '.post.page-content br').try(:next)
			final_data[:phone] = extract_data(html: html_doc, css_selectors: '.post.page-content br').next.text.strip
		end
		final_data[:website] = details_url
		final_data[:county] = 'USA'
		final_data[:type_of_services] = 'Housing'	
		final_data
	end

	def store_location(location_data_hash: raise)
		loc = Location.new(location_data_hash)
		begin 
			return loc.save
		rescue => e
			Rails.logger.error "Error occured at #{_method_}: #{e}"
		end
	end
end