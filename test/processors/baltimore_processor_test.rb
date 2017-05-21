require 'test_helper'

class BaltimoreProcessorTest < ActiveSupport::TestCase
  let(:domain) do
    Domain.create(
      kind: "BaltimoreProcessor",
      url: 'https://data.baltimorecity.gov/resource/4adc-a5y9.json'
    )
  end

  it "loads the data from the Baltimore API endpoint in to the database" do
    VCR.use_cassette('baltimore_json_fetcher') do
      domain.perform_processor
    end
    relation = Location.where(domain: domain)
    assert relation.any?
    names = relation.map(&:name)
    refute names.include?(nil)
    assert names.include?("Paul's Place")
  end

  it "loads latitude & longitude data as strings" do
    VCR.use_cassette('baltimore_json_fetcher') do
      domain.perform_processor
    end
    relation = Location.where(domain: domain)
    test_location = relation.find_by(name: "Sarah's Hope Mount Street Shelter")
    assert test_location.latitude, "-76.644556"
    assert test_location.longitude, "39.301778"
  end

  it 'associates created locations with services' do
    VCR.use_cassette('baltimore_json_fetcher') do
      domain.perform_processor
    end

    location = Location.find_by(domain: domain,
                                service_description: 'Emergency Shelter')

    assert location, 'Location missing'
    refute_empty location.services
    assert_equal 'Emergency Shelter', location.services.first.name
  end
end
