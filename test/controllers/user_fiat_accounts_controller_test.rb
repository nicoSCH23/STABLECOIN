require 'test_helper'

class UserFiatAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_fiat_account = user_fiat_accounts(:one)
  end

  test "should get index" do
    get user_fiat_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_user_fiat_account_url
    assert_response :success
  end

  test "should create user_fiat_account" do
    assert_difference('UserFiatAccount.count') do
      post user_fiat_accounts_url, params: { user_fiat_account: {  } }
    end

    assert_redirected_to user_fiat_account_url(UserFiatAccount.last)
  end

  test "should show user_fiat_account" do
    get user_fiat_account_url(@user_fiat_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_fiat_account_url(@user_fiat_account)
    assert_response :success
  end

  test "should update user_fiat_account" do
    patch user_fiat_account_url(@user_fiat_account), params: { user_fiat_account: {  } }
    assert_redirected_to user_fiat_account_url(@user_fiat_account)
  end

  test "should destroy user_fiat_account" do
    assert_difference('UserFiatAccount.count', -1) do
      delete user_fiat_account_url(@user_fiat_account)
    end

    assert_redirected_to user_fiat_accounts_url
  end
end
