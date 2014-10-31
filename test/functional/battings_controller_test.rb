require 'test_helper'

class BattingsControllerTest < ActionController::TestCase
  test "should get batting" do
    get :batting
    assert_response :success
  end

end
