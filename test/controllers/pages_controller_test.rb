require "test_helper"

describe PagesController do
  it "gets root" do
    get '/'
    assert_response :success
  end
end
