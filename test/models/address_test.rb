require "test_helper"

describe Address do
  let(:address) { Address.new }
  # valid_params = {location_id: 1, address_1: '123 some street', address_2: 'suite #4', city: 'Foo', state: 'NY', coutnry: 'US'}
 
  describe 'create' do 
	  it "must be valid" do
	  	# address = Address.create(:valid_params)
	    value(Address.create(location_id: 1, address_1: '123 some street', address_2: 'suite #4', city: 'Foo', state_province: 'NY', country: 'US')).must_be :valid?
	  	# value(Address.create(:users(:one)).must_be :valid?
	  end

	  # it "must require address_1" do
	  #   value(location_id: 1, address_2: 'suite #4', city: 'Foo', state: 'NY', coutnry: 'US').must_be :invalid?
	  # end

	  # it "must require city" do
	  #   value(address).must_be :valid?
	  # end

	  # it "must require state_provice" do
	  #   value(address).must_be :valid?
	  # end

	  # it "must require postal_code" do
	  #   value(address).must_be :valid?
	  # end

	  # it "must require country" do
	  #   value(address).must_be :valid?
	  # end
	end
end
