require 'test_helper'

class PapersubjectSubjectshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @papersubject_subjectship = papersubject_subjectships(:one)
  end

  test "should get index" do
    get papersubject_subjectships_url
    assert_response :success
  end

  test "should get new" do
    get new_papersubject_subjectship_url
    assert_response :success
  end

  test "should create papersubject_subjectship" do
    assert_difference('PapersubjectSubjectship.count') do
      post papersubject_subjectships_url, params: { papersubject_subjectship: {  } }
    end

    assert_redirected_to papersubject_subjectship_url(PapersubjectSubjectship.last)
  end

  test "should show papersubject_subjectship" do
    get papersubject_subjectship_url(@papersubject_subjectship)
    assert_response :success
  end

  test "should get edit" do
    get edit_papersubject_subjectship_url(@papersubject_subjectship)
    assert_response :success
  end

  test "should update papersubject_subjectship" do
    patch papersubject_subjectship_url(@papersubject_subjectship), params: { papersubject_subjectship: {  } }
    assert_redirected_to papersubject_subjectship_url(@papersubject_subjectship)
  end

  test "should destroy papersubject_subjectship" do
    assert_difference('PapersubjectSubjectship.count', -1) do
      delete papersubject_subjectship_url(@papersubject_subjectship)
    end

    assert_redirected_to papersubject_subjectships_url
  end
end
