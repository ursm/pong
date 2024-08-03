require "test_helper"

class MonthsControllerTest < ActionDispatch::IntegrationTest
  test "#show" do
    get "/years/2024/months/11"

    assert_select "article", 2
  end
end
