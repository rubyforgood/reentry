class Location < ApplicationRecord
  belongs_to :domain, optional: true
  has_many :phone_numbers
  has_many :location_services
  has_many :services, through: :location_services

  comma :ohana do
    id 'id'
    organization_id
    accessibility
    admin_emails
    alternate_name
    description
    email
    languages
    latitude
    longitude
    name
    short_desc
    transportation
    website
    virtual
  end

  def services_list
    #services.each.map(&:name).join(',')
  end

  #stubbed fields.
  def organization_id
    1
  end
  def accessibility; end
  def admin_emails; end
  def alternate_name; end
  def description
    name
  end
  def email; end
  def languages; end
  def short_desc; end
  def transportation; end
  def virtual ; end

end
