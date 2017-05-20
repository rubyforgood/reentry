class Location < ApplicationRecord
  belongs_to :domain
  has_many :phone_numbers
end
