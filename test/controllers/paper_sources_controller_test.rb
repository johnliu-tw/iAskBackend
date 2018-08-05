require 'test_helper'

class PaperSourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paper_source = paper_sources(:one)
  end

  test "should get index" do
    get paper_sources_url
    assert_response :success
  end

  test "should get new" do
    get new_paper_source_url
    assert_response :success
  end

  test "should create paper_source" do
    assert_difference('PaperSource.count') do
      post paper_sources_url, params: { paper_source: { name: @paper_source.name } }
    end

    assert_redirected_to paper_source_url(PaperSource.last)
  end

  test "should show paper_source" do
    get paper_source_url(@paper_source)
    assert_response :success
  end

  test "should get edit" do
    get edit_paper_source_url(@paper_source)
    assert_response :success
  end

  test "should update paper_source" do
    patch paper_source_url(@paper_source), params: { paper_source: { name: @paper_source.name } }
    assert_redirected_to paper_source_url(@paper_source)
  end

  test "should destroy paper_source" do
    assert_difference('PaperSource.count', -1) do
      delete paper_source_url(@paper_source)
    end

    assert_redirected_to paper_sources_url
  end
end
