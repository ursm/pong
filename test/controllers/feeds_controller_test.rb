require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    get '/feed', headers: {'Accept' => 'application/atom+xml'}

    assert_response :ok
    assert_select 'entry', 4
  end
end
