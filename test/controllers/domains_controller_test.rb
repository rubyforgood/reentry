require "test_helper"

class DomainsControllerTest < ActionDispatch::IntegrationTest

  describe DomainsController do

    it "should get index if user is an admin" do
      sign_in users(:admin)
      get domains_path
      assert_response :success
    end

    it "should not get index for a non-admin user" do
      sign_in users(:user)
      get users_url
      assert_redirected_to root_path
    end

    it "should get new for admins" do
      sign_in users(:admin)
      get new_domain_url
      assert_response :success
    end

    it "should get new for non_admins" do
      sign_in users(:user)
      get new_domain_url
      assert_response :success
    end

    it "should create new domain for users" do
      sign_in users(:user)
      assert_difference('Domain.count', +1) do
        post domains_url, params: { domain: { name: "Test domain", kind: "Test Processor", url: "https://testdomain.com", description: "Test" } }
      end
      assert_redirected_to domains_url
    end

    it "should create new domain for admin" do
      sign_in users(:admin)
      assert_difference('Domain.count', +1) do
        post domains_url, params: { domain: { name: "Test domain", kind: "Test Processor", url: "https://testdomain.com", description: "Test" } }
      end
      assert_redirected_to domains_url
    end

    it "should update domain if admin" do
      sign_in users(:admin)
      domain = domains(:one)
      patch domain_url(domain), params: { domain: { description: "Another Test", status: "active" } }
      assert_redirected_to domain_url
    end

    it "should not update domain if non-admin" do
      sign_in users(:user)
      domain = domains(:one)
      patch domain_url(domain), params: { domain: { description: "Another Test", status: "active" } }
      assert_redirected_to root_url
    end

    it "should destroy domain if admin" do
      sign_in users(:admin)
      domain = domains(:one)
      assert_difference('Domain.count', -1) do
        delete domain_url(domain)
      end
      assert_redirected_to domains_url
    end

    it "should not destroy domain if non-admin" do
      sign_in users(:user)
      domain = domains(:one)
      assert_no_difference('Domain.count') do
        delete domain_url(domain)
      end
      assert_redirected_to root_url
    end

    it 'should get perform_processor' do
      sign_in users(:admin)
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
end
