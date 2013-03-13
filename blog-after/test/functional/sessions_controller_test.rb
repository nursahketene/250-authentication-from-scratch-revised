require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = User.new( email: "example@email.com",
                      password: "1234",
                      password_confirmation: "1234")
    @user.save
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    post :create, email: @user.email, password: @user.password 
    assert_response :redirect
    assert_redirected_to root_url
    assert session[:user_id].present?
    assert_equal "Logged in!", flash[:notice]
  end

  test "should not login with wrong password or email" do
    post :create, email: "invalid", password: "12"
    assert_template :new
    assert_equal "Email or password is invalid", flash[:alert]
  end

end
