require 'test_helper'

class UserStableAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_stable_account = user_stable_accounts(:one)
  end

  test "should get index" do
    get user_stable_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_user_stable_account_url
    assert_response :success
  end

  test "should create user_stable_account" do
    assert_difference('UserStableAccount.count') do
      post user_stable_accounts_url, params: { user_stable_account: {  } }
    end

    assert_redirected_to user_stable_account_url(UserStableAccount.last)
  end

  test "should show user_stable_account" do
    get user_stable_account_url(@user_stable_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_stable_account_url(@user_stable_account)
    assert_response :success
  end

  test "should update user_stable_account" do
    patch user_stable_account_url(@user_stable_account), params: { user_stable_account: {  } }
    assert_redirected_to user_stable_account_url(@user_stable_account)
  end

  test "should destroy user_stable_account" do
    assert_difference('UserStableAccount.count', -1) do
      delete user_stable_account_url(@user_stable_account)
    end

    assert_redirected_to user_stable_accounts_url
  end
end
