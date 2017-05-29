class AddressNormalizer

	def self.normalize(address_string: raise)
		query = Geocoder.search(address_string).first
		address1,city,state_zip,country = query.data["formatted_address"].split(',')
	    state,zip = state_zip.split(' ')
	    output = { 
		  'address' => query.data["formatted_address"],
	      'address1' => address1,
	      'address2' => nil,
		    'city' => city,
		    'state_province' => state,
		    'postal_code' => zip,
		    'country' => country,
		    'lat' => query.data["geometry"]["location"]["lat"],
		    'lng' => query.data["geometry"]["location"]["lng"]  
	    }
	end
end