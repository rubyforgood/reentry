class Location < ApplicationRecord
  belongs_to :domain, optional: true
  has_many :phone_numbers
end
