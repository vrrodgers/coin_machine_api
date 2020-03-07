class AddSlugToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :slug, :string, null: false
    add_index :coins, :slug, unique: true
  end
end