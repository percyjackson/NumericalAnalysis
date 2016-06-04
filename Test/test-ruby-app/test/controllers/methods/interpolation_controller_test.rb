require 'test_helper'

class Methods::InterpolationControllerTest < ActionController::TestCase
  test "should get lagrange" do
    get :lagrange
    assert_response :success
  end

  test "should get newton" do
    get :newton
    assert_response :success
  end

  test "should get linear" do
    get :linear
    assert_response :success
  end

  test "should get cubic" do
    get :cubic
    assert_response :success
  end

  test "should get reduction" do
    get :reduction
    assert_response :success
  end

end
