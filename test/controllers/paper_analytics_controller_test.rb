require 'test_helper'

class PaperAnalyticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get paper_analytics_index_url
    assert_response :success
  end

end
