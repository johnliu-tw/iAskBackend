require 'test_helper'

class SelectionQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @selection_question = selection_questions(:one)
  end

  test "should get index" do
    get selection_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_selection_question_url
    assert_response :success
  end

  test "should create selection_question" do
    assert_difference('SelectionQuestion.count') do
      post selection_questions_url, params: { selection_question: { active: @selection_question.active, analysis: @selection_question.analysis, analysis_att: @selection_question.analysis_att, analysis_url: @selection_question.analysis_url, answer: @selection_question.answer, answer_count: @selection_question.answer_count, first_correct_count: @selection_question.first_correct_count, optionCount: @selection_question.optionCount, questionA: @selection_question.questionA, questionA_attr: @selection_question.questionA_attr, questionB: @selection_question.questionB, questionB_attr: @selection_question.questionB_attr, questionC: @selection_question.questionC, questionC_attr: @selection_question.questionC_attr, questionD: @selection_question.questionD, questionD_attr: @selection_question.questionD_attr, questionE: @selection_question.questionE, questionE_attr: @selection_question.questionE_attr, questionF: @selection_question.questionF, questionF_attr: @selection_question.questionF_attr, question_type: @selection_question.question_type, title: @selection_question.title, title_attr: @selection_question.title_attr } }
    end

    assert_redirected_to selection_question_url(SelectionQuestion.last)
  end

  test "should show selection_question" do
    get selection_question_url(@selection_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_selection_question_url(@selection_question)
    assert_response :success
  end

  test "should update selection_question" do
    patch selection_question_url(@selection_question), params: { selection_question: { active: @selection_question.active, analysis: @selection_question.analysis, analysis_att: @selection_question.analysis_att, analysis_url: @selection_question.analysis_url, answer: @selection_question.answer, answer_count: @selection_question.answer_count, first_correct_count: @selection_question.first_correct_count, optionCount: @selection_question.optionCount, questionA: @selection_question.questionA, questionA_attr: @selection_question.questionA_attr, questionB: @selection_question.questionB, questionB_attr: @selection_question.questionB_attr, questionC: @selection_question.questionC, questionC_attr: @selection_question.questionC_attr, questionD: @selection_question.questionD, questionD_attr: @selection_question.questionD_attr, questionE: @selection_question.questionE, questionE_attr: @selection_question.questionE_attr, questionF: @selection_question.questionF, questionF_attr: @selection_question.questionF_attr, question_type: @selection_question.question_type, title: @selection_question.title, title_attr: @selection_question.title_attr } }
    assert_redirected_to selection_question_url(@selection_question)
  end

  test "should destroy selection_question" do
    assert_difference('SelectionQuestion.count', -1) do
      delete selection_question_url(@selection_question)
    end

    assert_redirected_to selection_questions_url
  end
end
