class OhanaRecordset
  @@id = 0
  def initialize(location)
    @id = @@id
    @@id += 1
    @location = location
  end

  def organization
    {id: @id, name: @location.name, description: @location.services}
  end

  def location
    {id: @id, organization_id: @id, name: @location.name, description: @location.services}
  end

  def address
    address_data = parse_address(@location.address)
    address_data.merge({id: @id, location_id: @id})
  end

  private

  def parse_address(address_string)
    pieces = address_string.split(',')
    statezip = pieces.last.split(' ')
    city = pieces[-2]
    {address_1: pieces[0..-3].join, city: city.strip, state_province: statezip.first, postal_code: statezip.last, country: 'US'}
  end
end
