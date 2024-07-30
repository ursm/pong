require "test_helper"

class SmokeTest < ActionDispatch::IntegrationTest
  test "top" do
    get "/"

    assert_select "article", 4
  end

  test "year" do
    get "/years/2024"

    assert_select "article", 3
  end

  test "month" do
    get "/years/2024/months/11"

    assert_select "article", 2
  end

  test "day" do
    get "/years/2024/months/11/days/01"

    assert_select "article", 1
  end
end
