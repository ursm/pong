require "test_helper"

class FeedTest < ActionDispatch::IntegrationTest
  test "feed" do
    get "/feed.atom"

    assert_select "entry", 4
  end
end
