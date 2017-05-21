class Domain < ApplicationRecord
  PROCESSORS = {
    'DOJProcessor' => DOJProcessor,
    'BaltimoreProcessor' => BaltimoreProcessor
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
