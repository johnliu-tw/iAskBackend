require 'test_helper'

class UserAnalyticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_analytics_index_url
    assert_response :success
  end

end
