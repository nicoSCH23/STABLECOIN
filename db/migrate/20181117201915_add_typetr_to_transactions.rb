class AddTypetrToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :typetr, :string
  end
end
