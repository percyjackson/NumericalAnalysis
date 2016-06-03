require 'test_helper'

class Methods::EqsystemControllerTest < ActionController::TestCase
  test "should get gaussseidel" do
    get :gaussseidel
    assert_response :success
  end

  test "should get richardson" do
    get :richardson
    assert_response :success
  end

  test "should get sor" do
    get :sor
    assert_response :success
  end

end
