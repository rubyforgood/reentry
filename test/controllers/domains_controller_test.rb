require "test_helper"

class DomainsControllerTest < ActionController::TestCase
	test "should get perform_processor" do
    	get perform_processor_url, params: { id: 1 }
    	assert_redirected_to(domain_path)
  	end
end
