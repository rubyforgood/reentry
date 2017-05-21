class Domain < ApplicationRecord
  PROCESSORS = {
    'BaltimoreProcessor' => BaltimoreProcessor,
    'DOJProcessor' => DOJProcessor,
    'ShelterListingsProcessor' => ShelterListingsProcessor
  }

  has_many :domain_services
  has_many :services, through: :domain_services

  validates :status, inclusion: { in: %w(active review inactive),
    message: "%{value} is not a valid status" }

  def perform_processor
    processor.perform(id)
  end

  private

  def processor
    PROCESSORS.fetch(kind).new
  end
end
