require 'test_helper'

class IncFiatAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inc_fiat_account = inc_fiat_accounts(:one)
  end

  test "should get index" do
    get inc_fiat_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_inc_fiat_account_url
    assert_response :success
  end

  test "should create inc_fiat_account" do
    assert_difference('IncFiatAccount.count') do
      post inc_fiat_accounts_url, params: { inc_fiat_account: {  } }
    end

    assert_redirected_to inc_fiat_account_url(IncFiatAccount.last)
  end

  test "should show inc_fiat_account" do
    get inc_fiat_account_url(@inc_fiat_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_inc_fiat_account_url(@inc_fiat_account)
    assert_response :success
  end

  test "should update inc_fiat_account" do
    patch inc_fiat_account_url(@inc_fiat_account), params: { inc_fiat_account: {  } }
    assert_redirected_to inc_fiat_account_url(@inc_fiat_account)
  end

  test "should destroy inc_fiat_account" do
    assert_difference('IncFiatAccount.count', -1) do
      delete inc_fiat_account_url(@inc_fiat_account)
    end

    assert_redirected_to inc_fiat_accounts_url
  end
end
