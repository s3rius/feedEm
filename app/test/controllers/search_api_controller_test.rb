require 'test_helper'

class SearchApiControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get search_api_search_url
    assert_response :success
  end

end
