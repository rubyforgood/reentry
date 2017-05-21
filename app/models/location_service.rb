class LocationService < ApplicationRecord
  belongs_to :location
  belongs_to :service

  validates :status, inclusion: { in: %w(active defunct inactive),
    message: "%{value} is not a valid status" }

end
