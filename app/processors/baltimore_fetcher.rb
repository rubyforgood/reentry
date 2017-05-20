class BaltimoreFetcher
  attr_accessor :uri

  def initialize(domain = nil)
    domain or @uri = 'https://data.baltimorecity.gov/resource/4adc-a5y9.json'
    @uri ||= URI.parse(domain.url)
  end

  def fetch
    @entries = JSON.parse(uri.open.read)
  end

  def records(keymap = JSON_TO_LOCATION_COLUMNS_MAP)
    @entries.map do |entry|
      record = entry.keys.each_with_object({}) do |key, memo|
        next unless keymap[key]
        memo[keymap[key]] = entry[key]
      end
      record[:address] = "#{entry["location_1_address"]}, #{entry["location_1_city"]}, #{entry["location_1_state"]}"
      record[:phone] = [record[:phone]]
      record[:longitude] = entry["location_1"]["coordinates"].first.to_s
      record[:latitude] = entry["location_1"]["coordinates"].last.to_s
      record
    end
  end

  private

  JSON_TO_LOCATION_COLUMNS_MAP = {
    "organization" => :name,
    "phone" => :phone,
    "url" => :website,
  }.freeze
end
