class CreateUserFiatAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_fiat_accounts do |t|
      t.string :currency_code
      t.float :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
