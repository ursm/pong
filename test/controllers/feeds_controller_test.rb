require "test_helper"

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "#show" do
    get "/feed.atom"

    assert_select "entry", 4
  end
end
