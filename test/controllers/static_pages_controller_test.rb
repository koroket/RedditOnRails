require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get addpost" do
    get :addpost
    assert_response :success
  end

end
