class CreateIncFiatAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :inc_fiat_accounts do |t|
      t.string :currency_code
      t.float :amount

      t.timestamps
    end
  end
end
