class Loader
  Result = ImmutableStruct.new :success?, :error
  ERROR_MESSAGE = 'ERROR: Processor::Loader.load! transaction failed!'

  def self.load!(data, klass: Location, **kwargs)
    begin
      ActiveRecord::Base.transaction do
        data.each do |record|
          klass.find_or_create_by!(
            county:           record[:county],
            name:             record[:name],
            address:          record[:address],
            phone:            record[:phone],
            website:          record[:website],
            services:         record[:services],
            type_of_services: record[:type],
            **kwargs
          )
        end
      end
    rescue ActiveRecord::RecordInvalid
      Result.new success: false, error: ERROR_MESSAGE
    else
      Result.new success: true, error: nil
    end
  end
end
