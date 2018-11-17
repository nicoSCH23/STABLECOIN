require 'test_helper'

class IncStableAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inc_stable_account = inc_stable_accounts(:one)
  end

  test "should get index" do
    get inc_stable_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_inc_stable_account_url
    assert_response :success
  end

  test "should create inc_stable_account" do
    assert_difference('IncStableAccount.count') do
      post inc_stable_accounts_url, params: { inc_stable_account: {  } }
    end

    assert_redirected_to inc_stable_account_url(IncStableAccount.last)
  end

  test "should show inc_stable_account" do
    get inc_stable_account_url(@inc_stable_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_inc_stable_account_url(@inc_stable_account)
    assert_response :success
  end

  test "should update inc_stable_account" do
    patch inc_stable_account_url(@inc_stable_account), params: { inc_stable_account: {  } }
    assert_redirected_to inc_stable_account_url(@inc_stable_account)
  end

  test "should destroy inc_stable_account" do
    assert_difference('IncStableAccount.count', -1) do
      delete inc_stable_account_url(@inc_stable_account)
    end

    assert_redirected_to inc_stable_accounts_url
  end
end
