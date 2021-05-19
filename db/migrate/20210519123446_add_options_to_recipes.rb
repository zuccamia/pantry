class AddOptionsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :status, :integer, default: 0
  end
end
