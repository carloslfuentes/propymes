require 'test_helper'

class CitesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
