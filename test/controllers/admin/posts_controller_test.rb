require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_request :post, "https://pubsubhubbub.appspot.com/publish"
  end

  test "#create" do
    post "/admin/posts", params: {
      post: {
        title: "New Post",
        body:  "This is a new post."
      }
    }

    assert_redirected_to "/admin"
    assert_published
  end

  test "#update" do
    post = posts(:one)

    patch "/admin/posts/#{post.id}", params: {
      post: {
        title: "Updated Post",
        body:  "This is an updated post."
      }
    }

    assert_redirected_to "/admin"
    assert_published
  end

  private

  def assert_published
    assert_requested :post, "https://pubsubhubbub.appspot.com/publish", **{
      headers: {
        "Content-Type" => "application/x-www-form-urlencoded"
      },

      body: {
        "hub.mode" => "publish",
        "hub.url"  => "http://www.example.com/feed.atom"
      }
    }
  end
end
