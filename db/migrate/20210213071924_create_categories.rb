class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :main_category
      t.string :sub_category

      t.timestamps
    end
  end
end
