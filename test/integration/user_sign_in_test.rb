require "test_helper"

class SigninTest < ActionDispatch::IntegrationTest

  setup do
      @user = User.create(email: "user@mail.com", password: Devise::Encryptor.digest(User, "password"), admin: false, confirmed_at: "2016-01-02 08:31:23")
      @admin = User.create(email: "admin@mail.com", password: Devise::Encryptor.digest(User, "password"), admin: true, confirmed_at: "2016-01-02 08:31:23")
  end

  describe "UserSignIn Integration Test" do

    it "does not sign in a user with incorrect email" do
      get new_user_session_path
      assert_equal 200, status
      post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' =>  "wrongpassword" }
      assert_equal new_user_session_path, path
    end

    it "does not sign in a user with incorrect email" do
      get new_user_session_path
      assert_equal 200, status
      post user_session_path, params: { 'user[email]' => "wrong@mail.com", 'user[password]' =>  @user.password }
      assert_equal new_user_session_path, path
    end

    it "signs in valid user and redirects to root_url with proper navigation" do
      get new_user_session_path
      assert_equal 200, status
      post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' =>  @user.password }
      assert_redirected_to root_url
      follow_redirect!
      assert_select "a[href=?]", new_domain_path
      assert_select "a[href=?]", destroy_user_session_path
    end

    it "signs in valid admin user and redirects to root_url with proper navigation " do
      get new_user_session_path
      assert_equal 200, status
      post user_session_path, params: { 'user[email]' => @admin.email, 'user[password]' =>  @admin.password }
      assert_redirected_to root_url
      follow_redirect!
      assert_select "a[href=?]", new_domain_path
      assert_select "a[href=?]", domains_path
      assert_select "a[href=?]", locations_path
      assert_select "a[href=?]", users_path
      assert_select "a[href=?]", destroy_user_session_path
    end

  end
end
