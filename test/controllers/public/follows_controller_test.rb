require "test_helper"

class Public::FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get public_follows_followings_url
    assert_response :success
  end

  test "should get followers" do
    get public_follows_followers_url
    assert_response :success
  end
end
