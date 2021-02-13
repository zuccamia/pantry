class CreateRecipeAmounts < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_amounts do |t|
      t.string :description
      t.references :item, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
