require 'test_helper'

class Methods::EqsystemControllerTest < ActionController::TestCase
  test "should get gausselimination" do
    get :gausselimination
    assert_response :success
  end

  test "should get lu" do
    get :lu
    assert_response :success
  end

end
