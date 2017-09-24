require 'test_helper'

class PaperSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paper_subject = paper_subjects(:one)
  end

  test "should get index" do
    get paper_subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_paper_subject_url
    assert_response :success
  end

  test "should create paper_subject" do
    assert_difference('PaperSubject.count') do
      post paper_subjects_url, params: { paper_subject: { active: @paper_subject.active, title: @paper_subject.title, title_view: @paper_subject.title_view } }
    end

    assert_redirected_to paper_subject_url(PaperSubject.last)
  end

  test "should show paper_subject" do
    get paper_subject_url(@paper_subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_paper_subject_url(@paper_subject)
    assert_response :success
  end

  test "should update paper_subject" do
    patch paper_subject_url(@paper_subject), params: { paper_subject: { active: @paper_subject.active, title: @paper_subject.title, title_view: @paper_subject.title_view } }
    assert_redirected_to paper_subject_url(@paper_subject)
  end

  test "should destroy paper_subject" do
    assert_difference('PaperSubject.count', -1) do
      delete paper_subject_url(@paper_subject)
    end

    assert_redirected_to paper_subjects_url
  end
end
