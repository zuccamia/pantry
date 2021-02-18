class AddInfosToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :summary, :text
    add_column :recipes, :instructions, :text
    add_column :recipes, :image, :string
  end
end
