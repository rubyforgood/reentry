class Normalizer
  def self.normalize(parsed_array, normalizers: nil)
    parsed_array.map do |org_hash|
      {
        county:           org_hash[:county],
        name:             org_hash[:organization],
        address:          org_hash[:address],
        phone:            org_hash[:phone],
        website:          org_hash[:website],
        services:         org_hash[:services],
        type_of_services: org_hash[:type]
      }
    end
  end
end
