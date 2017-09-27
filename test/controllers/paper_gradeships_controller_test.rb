require 'test_helper'

class PaperGradeshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paper_gradeship = paper_gradeships(:one)
  end

  test "should get index" do
    get paper_gradeships_url
    assert_response :success
  end

  test "should get new" do
    get new_paper_gradeship_url
    assert_response :success
  end

  test "should create paper_gradeship" do
    assert_difference('PaperGradeship.count') do
      post paper_gradeships_url, params: { paper_gradeship: {  } }
    end

    assert_redirected_to paper_gradeship_url(PaperGradeship.last)
  end

  test "should show paper_gradeship" do
    get paper_gradeship_url(@paper_gradeship)
    assert_response :success
  end

  test "should get edit" do
    get edit_paper_gradeship_url(@paper_gradeship)
    assert_response :success
  end

  test "should update paper_gradeship" do
    patch paper_gradeship_url(@paper_gradeship), params: { paper_gradeship: {  } }
    assert_redirected_to paper_gradeship_url(@paper_gradeship)
  end

  test "should destroy paper_gradeship" do
    assert_difference('PaperGradeship.count', -1) do
      delete paper_gradeship_url(@paper_gradeship)
    end

    assert_redirected_to paper_gradeships_url
  end
end
