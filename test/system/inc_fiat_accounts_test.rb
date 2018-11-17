require "application_system_test_case"

class IncFiatAccountsTest < ApplicationSystemTestCase
  setup do
    @inc_fiat_account = inc_fiat_accounts(:one)
  end

  test "visiting the index" do
    visit inc_fiat_accounts_url
    assert_selector "h1", text: "Inc Fiat Accounts"
  end

  test "creating a Inc fiat account" do
    visit inc_fiat_accounts_url
    click_on "New Inc Fiat Account"

    click_on "Create Inc fiat account"

    assert_text "Inc fiat account was successfully created"
    click_on "Back"
  end

  test "updating a Inc fiat account" do
    visit inc_fiat_accounts_url
    click_on "Edit", match: :first

    click_on "Update Inc fiat account"

    assert_text "Inc fiat account was successfully updated"
    click_on "Back"
  end

  test "destroying a Inc fiat account" do
    visit inc_fiat_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inc fiat account was successfully destroyed"
  end
end
