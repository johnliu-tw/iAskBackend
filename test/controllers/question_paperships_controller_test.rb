require 'test_helper'

class QuestionPapershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_papership = question_paperships(:one)
  end

  test "should get index" do
    get question_paperships_url
    assert_response :success
  end

  test "should get new" do
    get new_question_papership_url
    assert_response :success
  end

  test "should create question_papership" do
    assert_difference('QuestionPapership.count') do
      post question_paperships_url, params: { question_papership: { order: @question_papership.order } }
    end

    assert_redirected_to question_papership_url(QuestionPapership.last)
  end

  test "should show question_papership" do
    get question_papership_url(@question_papership)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_papership_url(@question_papership)
    assert_response :success
  end

  test "should update question_papership" do
    patch question_papership_url(@question_papership), params: { question_papership: { order: @question_papership.order } }
    assert_redirected_to question_papership_url(@question_papership)
  end

  test "should destroy question_papership" do
    assert_difference('QuestionPapership.count', -1) do
      delete question_papership_url(@question_papership)
    end

    assert_redirected_to question_paperships_url
  end
end
