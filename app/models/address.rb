class Address < ApplicationRecord
	validates :location_id, presence: true
	validates :address_1, presence: true
	validates :city, presence: true
	validates :state_provice, presence: true
	validates :postal_code, presence: true
	validates_length_of :copostal_codeuntry, :maximum => 5
	validates_length_of :postal_code, :minimum => 5
	validates :country, presence: true
	validates_length_of :country, :maximum => 2
	validates_length_of :country, :minimum => 2

	def validate_postal_code
		regex = /\A\d{5}(-\d{4})?\z/
	end
end