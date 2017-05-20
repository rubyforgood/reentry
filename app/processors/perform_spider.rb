require 'open-uri'
require 'nokogiri'

class PerformSpider
	def get_website_html(url: raise)
		Nokogiri::HTML(open(url))
	end

	def extract_data(html: raise, css_selectors: raise)
		html.css(css_selectors)
	end
end