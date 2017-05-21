class Normalizer
  def self.normalize(parsed_array,
                     phone_normalizer: PhoneNormalizer,
                     service_normalizer: ServiceNormalizer)
    parsed_array.map do |org_hash|
      {
        county:           org_hash[:county],
        name:             org_hash[:organization],
        address:          org_hash[:address],
        phone:            phone_normalizer.normalize(org_hash[:phone]),
        website:          org_hash[:website],
        service_description: org_hash[:services],
        services:         service_normalizer.normalize(org_hash[:type]),
        type_of_services: org_hash[:type]
      }
    end
  end
end
