class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :coin_name
      t.integer :transaction_type
      t.string :user_access_token

      t.timestamps
    end
  end
end
