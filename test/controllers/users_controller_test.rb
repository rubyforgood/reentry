require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:user_two)
  end

  describe UsersController do
    it "should allow admins to view users index" do
      sign_in users(:admin)
      get users_path
      assert_response :success
    end

    it "should not allow users to view users index" do
      sign_in users(:user)
      get users_path
      assert_redirected_to root_path
    end

    it "should allow admins to update users" do
      sign_in users(:admin)
      patch user_url(@user), params: { user: { admin: @user.admin } }
      assert_redirected_to users_url
      assert @user.admin = true
    end

    it "should not allow regular users to update users" do
      sign_in users(:user)
      patch user_url(@user), params: { user: { admin: @user.admin } }
      assert_redirected_to root_path
      assert_not @user.admin
    end

    it "shoud allow admins to delete users" do
      sign_in users(:admin)
      @user2 = users(:user_three)
      assert_difference('User.count', -1) do
        delete user_path(@user2)
      end
      assert_redirected_to users_url
    end

    it "should not allow regular users to delete users" do
      sign_in users(:user)
      @user2 = users(:user_three)
      assert_no_difference('User.count') do
        delete user_path(@user2)
      end
      assert_redirected_to root_path
    end
  end
end
