class CreateUserStableAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_stable_accounts do |t|
      t.float :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
