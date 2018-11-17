class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.float :amount_fiat
      t.float :amount_stable
      t.float :exchange_rate
      t.string :currency_code
      t.references :inc_fiat_account, foreign_key: true
      t.references :inc_stable_account, foreign_key: true
      t.references :user_stable_account, foreign_key: true
      t.references :user_fiat_account, foreign_key: true

      t.timestamps
    end
  end
end
