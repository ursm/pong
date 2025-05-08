require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get "/"

    assert_response :ok
    assert_select "article", 4
  end
end
