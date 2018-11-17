class AddBankToIncFiatAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :inc_fiat_accounts, :bank, :string
  end
end
