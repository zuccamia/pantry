class CreateShoppingAmounts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_amounts do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.string :description
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
