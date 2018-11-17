require "application_system_test_case"

class UserFiatAccountsTest < ApplicationSystemTestCase
  setup do
    @user_fiat_account = user_fiat_accounts(:one)
  end

  test "visiting the index" do
    visit user_fiat_accounts_url
    assert_selector "h1", text: "User Fiat Accounts"
  end

  test "creating a User fiat account" do
    visit user_fiat_accounts_url
    click_on "New User Fiat Account"

    click_on "Create User fiat account"

    assert_text "User fiat account was successfully created"
    click_on "Back"
  end

  test "updating a User fiat account" do
    visit user_fiat_accounts_url
    click_on "Edit", match: :first

    click_on "Update User fiat account"

    assert_text "User fiat account was successfully updated"
    click_on "Back"
  end

  test "destroying a User fiat account" do
    visit user_fiat_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User fiat account was successfully destroyed"
  end
end
