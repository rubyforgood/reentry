require "test_helper"

describe UsersController do
  it "should get manage" do
    get users_manage_url
    value(response).must_be :success?
  end

end
