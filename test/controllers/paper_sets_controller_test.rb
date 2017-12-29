require 'test_helper'

class PaperSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paper_set = paper_sets(:one)
  end

  test "should get index" do
    get paper_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_paper_set_url
    assert_response :success
  end

  test "should create paper_set" do
    assert_difference('PaperSet.count') do
      post paper_sets_url, params: { paper_set: { active: @paper_set.active, description: @paper_set.description, price: @paper_set.price, public_date: @paper_set.public_date, title: @paper_set.title } }
    end

    assert_redirected_to paper_set_url(PaperSet.last)
  end

  test "should show paper_set" do
    get paper_set_url(@paper_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_paper_set_url(@paper_set)
    assert_response :success
  end

  test "should update paper_set" do
    patch paper_set_url(@paper_set), params: { paper_set: { active: @paper_set.active, description: @paper_set.description, price: @paper_set.price, public_date: @paper_set.public_date, title: @paper_set.title } }
    assert_redirected_to paper_set_url(@paper_set)
  end

  test "should destroy paper_set" do
    assert_difference('PaperSet.count', -1) do
      delete paper_set_url(@paper_set)
    end

    assert_redirected_to paper_sets_url
  end
end
