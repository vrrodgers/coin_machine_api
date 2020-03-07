class AddSlackUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :slack_url, :string
  end
end
