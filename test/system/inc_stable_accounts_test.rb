require "application_system_test_case"

class IncStableAccountsTest < ApplicationSystemTestCase
  setup do
    @inc_stable_account = inc_stable_accounts(:one)
  end

  test "visiting the index" do
    visit inc_stable_accounts_url
    assert_selector "h1", text: "Inc Stable Accounts"
  end

  test "creating a Inc stable account" do
    visit inc_stable_accounts_url
    click_on "New Inc Stable Account"

    click_on "Create Inc stable account"

    assert_text "Inc stable account was successfully created"
    click_on "Back"
  end

  test "updating a Inc stable account" do
    visit inc_stable_accounts_url
    click_on "Edit", match: :first

    click_on "Update Inc stable account"

    assert_text "Inc stable account was successfully updated"
    click_on "Back"
  end

  test "destroying a Inc stable account" do
    visit inc_stable_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inc stable account was successfully destroyed"
  end
end
