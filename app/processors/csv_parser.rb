class CSVParser
  HEADER_ROW = 1
  REQUIRED_HEADERS_AND_POSITIONS = {
    'County'       => 0,
    'Organization' => 1,
    'Address'      => 2,
    'Phone'        => 3,
    'Website'      => 4,
    'Services'     => 5,
    'Type'         => 6,
  }.freeze

  class << self
    def parse(csv)
      csv = CSV.read(csv, headers: true)
      raise Errors::UnprocessableEntity if missing_required_headers?(csv)

      csv_with_headers_removed = csv.to_a.drop(HEADER_ROW)
      map_to_hash(data: csv_with_headers_removed)
    end

    private

    def missing_required_headers?(csv)
      csv.headers.sort != REQUIRED_HEADERS_AND_POSITIONS.keys.sort
    end

    def map_to_hash(data:, headers: REQUIRED_HEADERS_AND_POSITIONS)
      data.map do |row|
        next if header_row?(row)

        headers.each_with_object({}) do |(header, position), hash|
          hash[symbolize(header)] = row[position]
        end
      end.compact
    end

    def header_row?(row)
      row.first == REQUIRED_HEADERS_AND_POSITIONS.keys.first
    end

    def symbolize(string)
      string.parameterize.underscore.to_sym
    end
  end
end
