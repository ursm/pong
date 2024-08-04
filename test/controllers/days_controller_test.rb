require "test_helper"

class DaysControllerTest < ActionDispatch::IntegrationTest
  test "#show" do
    get "/years/2024/months/11/days/01"

    assert_select "article", 1
  end
end
