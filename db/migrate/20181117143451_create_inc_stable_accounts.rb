class CreateIncStableAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :inc_stable_accounts do |t|
      t.float :amount

      t.timestamps
    end
  end
end
