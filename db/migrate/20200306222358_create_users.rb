class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :access_token
      t.boolean :admin

      t.timestamps
    end
    add_index :users, :access_token, unique: true
  end
end
