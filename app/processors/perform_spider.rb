require 'open-uri'
require 'nokogiri'

class PerformSpider
	def get_website_html(url: raise)
		doc = Nokogiri::HTML(open(url))
	end

	def extract_data(css_selectors: raise)
		doc.css(css_selectors)
	end
end