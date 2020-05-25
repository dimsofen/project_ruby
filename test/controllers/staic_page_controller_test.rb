require 'test_helper'

class StaicPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get staic_page_home_url
    assert_response :success
  end

end
