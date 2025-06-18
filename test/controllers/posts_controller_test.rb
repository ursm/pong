require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get "/"

    assert_response :ok
    assert_select "article", 4
  end

  test "#show" do
    post = posts(:one)

    get "/posts/#{post.id}"

    assert_response :ok
    assert_select "h1", post.title
  end
end
