require "application_system_test_case"

class UserStableAccountsTest < ApplicationSystemTestCase
  setup do
    @user_stable_account = user_stable_accounts(:one)
  end

  test "visiting the index" do
    visit user_stable_accounts_url
    assert_selector "h1", text: "User Stable Accounts"
  end

  test "creating a User stable account" do
    visit user_stable_accounts_url
    click_on "New User Stable Account"

    click_on "Create User stable account"

    assert_text "User stable account was successfully created"
    click_on "Back"
  end

  test "updating a User stable account" do
    visit user_stable_accounts_url
    click_on "Edit", match: :first

    click_on "Update User stable account"

    assert_text "User stable account was successfully updated"
    click_on "Back"
  end

  test "destroying a User stable account" do
    visit user_stable_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User stable account was successfully destroyed"
  end
end
