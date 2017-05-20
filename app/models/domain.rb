class Domain < ApplicationRecord
  PROCESSORS = {
    'DOJProcessor' => DOJProcessor,
    'BaltimoreProcessor' => BaltimoreProcessor
  }

  has_many :domain_services
  has_many :services, through: :domain_services

  def perform_processor
    processor.perform(id)
  end

  private

  def processor
    PROCESSORS.fetch(kind).new
  end
end
