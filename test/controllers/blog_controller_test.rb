require 'test_helper'

class BlogControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get blog_new_url
    assert_response :success
  end

end
