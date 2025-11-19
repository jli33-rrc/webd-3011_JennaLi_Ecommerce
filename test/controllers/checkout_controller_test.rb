require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get checkout_show_url
    assert_response :success
  end

  test "should get process_order" do
    get checkout_process_order_url
    assert_response :success
  end

  test "should get complete" do
    get checkout_complete_url
    assert_response :success
  end
end
