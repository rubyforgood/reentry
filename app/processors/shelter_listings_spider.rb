require 'open-uri'
require 'nokogiri'

class ShelterListingsSpider
	doc = Nokogiri::HTML(open('http://www.shelterlistings.org/state/maryland.html'))

	# collect city links
	link_tags = doc.css('.wrapper #content .post.page-content table a')
	city_links = []
	detail_urls = []

	link_tags.each do |tag|
		city_links << tag['href'] 
		# limit the number of calls made 
		# so we don't make them too angry :)
		break if city_links.count > 1  
	end
	puts city_links.count

	# collect location urls
	city_links.each do |link|
		doc = Nokogiri::HTML(open(link))
		detail_urls << doc.css('table tr td a')[0]['href']
		p "collected #{detail_urls.count} detail links"

		# limit the number of calls made 
		# so we don't make them too angry :)
		break if detail_urls.count > 10
	end

	# loop through each details page and collect
	# organization name, phone, and address

	detail_urls.each do |link|
		doc = Nokogiri::HTML(open(link))
		name = doc.css('.post.page-content h2').children.first.text
		address = doc.css('.post.page-content br')[4].next.text.strip
		phone = doc.css('.post.page-content br')[5].next.text.strip
		raw_website = doc.css('.post.page-content .entry-content #grey_bar')[2].children[0].text
		# raw_website.nil? &&  ? (website = 'N/A') : (website = raw_website.gsub("Website: ", ""))
		website = link
		service = 'Homeless Shelter'


		puts "#{name}|#{address}|#{phone}|#{service}|#{website}"
	end

	private

		def extract_data(url: raise, css_selectors: )
			doc = Nokogiri::HTML(open(url))
			doc.css(css_selectors)
		end

end