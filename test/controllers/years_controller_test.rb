require "test_helper"

class YearsControllerTest < ActionDispatch::IntegrationTest
  test "#show" do
    get "/years/2024"

    assert_select "article", 3
  end
end
