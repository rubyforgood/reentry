class ShelterListingsProcessor < PerformSpider
	def perform(domain_id)
		domain = Domain.find(domain_id)
		url = domain.url
		run_shelter_listings_spider(domain_url: url)
	end

	def run_shelter_listings_spider(domain_url: raise)
		final_data = []
		cities_list = get_list_of_cities(url: domain_url)
		details_links = get_list_of_detail_links(links_array: cities_list)
		details_links.each do |link| 
			data_hash = extract_data_from_details_page(details_url:link)
			final_data << data_hash
		end
		final_data
	end

	def get_list_of_cities(url: raise)
		city_links = []
		html_doc = get_website_html(url: url)
		
		link_tags = extract_data(html: html_doc, css_selectors: '.wrapper #content .post.page-content table a')

		link_tags.each {|tag| city_links << tag['href'] ; puts "count ciy links #{city_links.count}"}
		city_links
	end

	def get_list_of_detail_links(links_array: raise)
		detail_links = []
		links_array.each do |link|
			html_doc = get_website_html(url: link)
			extracted_data = extract_data(html: html_doc, css_selectors: 'table tr td a')
			detail_links << extracted_data[0]['href'] unless extracted_data.nil?

			puts "count detail_links  #{detail_links.count}"
		end
		detail_links
	end

	def extract_data_from_details_page(details_url: raise)
		final_data = {}
		html_doc = get_website_html(url: details_url)
		
		final_data[:name] = extract_data(html: html_doc, css_selectors: '.post.page-content h2').children.first.text
		final_data[:address] = extract_shelterlistings_address(doc_html: html_doc)
		if extract_data(html: html_doc, css_selectors: '.post.page-content br').try(:next)
			final_data[:phone] = extract_data(html: html_doc, css_selectors: '.post.page-content br').next.text.strip
		end
		final_data[:website] = details_url
		final_data[:county] = 'USA'
		final_data[:type_of_services] = 'Housing'	
		final_data[:latitude] = 1
		final_data[:longitude] = 2
		final_data
	end

	def extract_shelterlistings_address(doc_html: raise)
		google_map_js = doc_html.css("script")[9].text
		lat, lng = google_map_js.scan(/-?\d+\.\d+/); 
		geo_localization = "#{lat},#{lng}"
		query = Geocoder.search(geo_localization).first.data
	end
end