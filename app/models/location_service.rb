class LocationService < ApplicationRecord
  belongs_to :location
  belongs_to :service

  validates :status, inclusion: { in: %w(active defunct inactive),
    message: "%{value} is not a valid status" }

  comma :ohana do
    id 'id'
    location_id 'location_id'
    program_id
    accepted_payments
    alternate_name
    application_process
    description
    eligibility
    email
    fees
    funding_sources
    interpretation_services
    keywords
    languages
    service :name => 'name'
    required_documents
    services_areas
    status 'status'
    wait_time
    website
    service :taxonomy_id => 'taxonomy_ids'
  end

  #stub methods
  def program_id; end
  def accepted_payments; end
  def alternate_name; end
  def application_process; end
  def description
    service.name
  end
  def eligibility; end
  def email; end
  def fees; end
  def funding_sources; end
  def interpretation_services; end
  def keywords; end
  def languages; end
  def required_documents; end
  def services_areas; end
  def status; end
  def wait_time; end
  def website; end

end
