class Normalizer
  def self.normalize(parsed_array, phone_normalizer: PhoneNormalizer)
    parsed_array.map do |org_hash|
      {
        county:           org_hash[:county],
        name:             org_hash[:organization],
        address:          org_hash[:address],
        phone:            phone_normalizer.normalize(org_hash[:phone]),
        website:          org_hash[:website],
        services:         org_hash[:services],
        type_of_services: org_hash[:type]
      }
    end
  end
end
