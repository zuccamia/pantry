class AddLineInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string
    add_column :uid, :provider, :string
  end
end