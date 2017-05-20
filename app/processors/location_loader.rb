class LocationLoader
  Result = ImmutableStruct.new :success?, :error
  ERROR_MESSAGE = 'ERROR: Processor::Loader.load! transaction failed!'

  def self.load!(data, **kwargs)
    begin
      ActiveRecord::Base.transaction do
        data.each do |record|
          location = Location.find_or_create_by!(
            county:           record[:county],
            name:             record[:name],
            address:          record[:address],
            website:          record[:website],
            services:         record[:services],
            type_of_services: record[:type],
            **kwargs
          )

          record[:phone].each_with_index do |phone_number, index|
            PhoneNumber.find_or_create_by!(
              number: phone_number,
              kind: "main #{index+1}",
              location_id: location.id
            )
          end
        end
      end
    rescue ActiveRecord::RecordInvalid
      Result.new success: false, error: ERROR_MESSAGE
    else
      Result.new success: true, error: nil
    end
  end
end
