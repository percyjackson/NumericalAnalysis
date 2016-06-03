require 'test_helper'

class Methods::OneVariableControllerTest < ActionController::TestCase
  test "should get bisection" do
    get :bisection
    assert_response :success
  end

  test "should get false_rule" do
    get :false_rule
    assert_response :success
  end

  test "should get fixed_point" do
    get :fixed_point
    assert_response :success
  end

  test "should get secant" do
    get :secant
    assert_response :success
  end

  test "should get newton_raphson" do
    get :newton_raphson
    assert_response :success
  end

  test "should get newton2" do
    get :newton2
    assert_response :success
  end

end
