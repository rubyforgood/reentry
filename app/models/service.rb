class Service < ApplicationRecord
  has_many :domain_services
  has_many :domains, through: :domain_services
  has_many :location_services
  has_many :locations, through: :location_services
end
