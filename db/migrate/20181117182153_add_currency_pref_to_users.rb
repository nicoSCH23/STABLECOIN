class AddCurrencyPrefToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :currency_pref, :string
  end
end
