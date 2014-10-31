require 'test_helper'

class OversControllerTest < ActionController::TestCase
  test "should get overs" do
    get :overs
    assert_response :success
  end

end
