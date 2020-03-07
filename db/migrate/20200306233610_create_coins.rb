class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.integer :value
      t.string :access_token

      t.timestamps
    end
  end
end
