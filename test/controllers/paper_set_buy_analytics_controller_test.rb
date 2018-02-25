require 'test_helper'

class PaperSetBuyAnalyticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get paper_set_buy_analytics_index_url
    assert_response :success
  end

end
