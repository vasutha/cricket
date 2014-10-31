require 'test_helper'

class ScoresControllerTest < ActionController::TestCase
  test "should get scores" do
    get :scores
    assert_response :success
  end

end
