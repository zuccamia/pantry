class RemoveColumnsFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :category, :string
    remove_column :items, :sub_category, :string
  end
end
