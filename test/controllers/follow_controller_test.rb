require "test_helper"

class FollowControllerTest < ActionDispatch::IntegrationTest
  test "should get following" do
    get follow_following_url
    assert_response :success
  end

  test "should get followers" do
    get follow_followers_url
    assert_response :success
  end

  test "should get create" do
    get follow_create_url
    assert_response :success
  end

  test "should get destroy" do
    get follow_destroy_url
    assert_response :success
  end
end
