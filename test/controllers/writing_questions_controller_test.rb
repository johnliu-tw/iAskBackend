require 'test_helper'

class WritingQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @writing_question = writing_questions(:one)
  end

  test "should get index" do
    get writing_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_writing_question_url
    assert_response :success
  end

  test "should create writing_question" do
    assert_difference('WritingQuestion.count') do
      post writing_questions_url, params: { writing_question: { active: @writing_question.active, analysis: @writing_question.analysis, analysis_att: @writing_question.analysis_att, analysis_url: @writing_question.analysis_url, title: @writing_question.title, title_attr: @writing_question.title_attr } }
    end

    assert_redirected_to writing_question_url(WritingQuestion.last)
  end

  test "should show writing_question" do
    get writing_question_url(@writing_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_writing_question_url(@writing_question)
    assert_response :success
  end

  test "should update writing_question" do
    patch writing_question_url(@writing_question), params: { writing_question: { active: @writing_question.active, analysis: @writing_question.analysis, analysis_att: @writing_question.analysis_att, analysis_url: @writing_question.analysis_url, title: @writing_question.title, title_attr: @writing_question.title_attr } }
    assert_redirected_to writing_question_url(@writing_question)
  end

  test "should destroy writing_question" do
    assert_difference('WritingQuestion.count', -1) do
      delete writing_question_url(@writing_question)
    end

    assert_redirected_to writing_questions_url
  end
end
