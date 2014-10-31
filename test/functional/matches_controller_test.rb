require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  test "should get match" do
    get :match
    assert_response :success
  end

end
