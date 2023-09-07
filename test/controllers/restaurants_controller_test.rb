require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get restaurants_new_url
    assert_response :success
  end

  test "should get confirm" do
    get restaurants_confirm_url
    assert_response :success
  end

  test "should get complete" do
    get restaurants_complete_url
    assert_response :success
  end

  test "should get index" do
    get restaurants_index_url
    assert_response :success
  end

  test "should get show" do
    get restaurants_show_url
    assert_response :success
  end

  test "should get edit" do
    get restaurants_edit_url
    assert_response :success
  end
end
