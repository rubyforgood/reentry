require "test_helper"

describe DomainsController do
  it 'should get perform_processor' do
    domain = Domain.create(
      kind: "BaltimoreProcessor",
      url: 'https://data.baltimorecity.gov/resource/4adc-a5y9.json'
    )

    assert_equal 0, Location.where(domain: domain).count

    VCR.use_cassette('baltimore_json_fetcher') do
      get perform_processor_url, params: { id: domain.id }
    end

    assert_equal 31, Location.where(domain: domain).count

    assert_redirected_to(domain_path(domain))
  end
end
