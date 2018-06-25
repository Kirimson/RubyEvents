require 'test_helper'

class OrganiserControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get organiser_register_url
    assert_response :success
  end

  test "should get login" do
    get organiser_login_url
    assert_response :success
  end

  test "should get myPage" do
    get organiser_myPage_url
    assert_response :success
  end

end
