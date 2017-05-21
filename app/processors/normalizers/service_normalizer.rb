class ServiceNormalizer
  SERVICE_SYNONYMS = {
    'Multi' => [],
    'Support Group' => ['Support Groups'],
  }

  class << self
    def normalize(service_data_string)
      return [] unless service_data_string
      service_data_string = service_data_string.titleize

      normalize_as_single_phrase(service_data_string) do
        normalize_by_subphrases(service_data_string) do
          [service_data_string]
        end
      end
    end

    private

    def normalize_as_single_phrase(service_data_string)
      SERVICE_SYNONYMS.fetch(service_data_string) do
        return yield
      end
    end

    def normalize_by_subphrases(service_data_string)
      return yield unless service_data_string.include?('&')

      service_data_string.split(/ *& */).flat_map do |subphrase|
        normalize_as_single_phrase(subphrase) do
          [subphrase]
        end
      end
    end
  end
end
