class Location < ApplicationRecord
  belongs_to :domain, optional: true
  has_many :phone_numbers
  has_many :location_services
  has_many :services, through: :location_services
end
