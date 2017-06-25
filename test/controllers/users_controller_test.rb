require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:user_two)
  end

  describe UsersController do
    it "should get index if user is admin" do
      sign_in users(:admin)
      get users_url
      assert_response :success
    end

    it "should not not get index if user is a non-admin" do
      sign_in users(:user)
      get users_url
      assert_redirected_to root_url
    end

    it "should update users if admin" do
      sign_in users(:admin)
      patch user_url(@user), params: { user: { admin: @user.admin } }
      assert_redirected_to users_url
      assert @user.admin = true
    end

    it "should not update users if non-admin user" do
      sign_in users(:user)
      patch user_url(@user), params: { user: { admin: @user.admin } }
      assert_redirected_to root_url
      assert_not @user.admin
    end

    it "should destroy users if admin" do
      sign_in users(:admin)
      @user2 = users(:user_three)
      assert_difference('User.count', -1) do
        delete user_url(@user2)
      end
      assert_redirected_to users_url
    end

    it "should not destroy users if non-admin user" do
      sign_in users(:user)
      @user2 = users(:user_three)
      assert_no_difference('User.count') do
        delete user_url(@user2)
      end
      assert_redirected_to root_url
    end
  end
end
