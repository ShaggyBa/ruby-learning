require "test_helper"

class LibraryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get library_index_url
    assert_response :success
  end

  test "should get choose_category" do
    get library_choose_category_url
    assert_response :success
  end

  test "should get display_book" do
    get library_display_book_url
    assert_response :success
  end
end
