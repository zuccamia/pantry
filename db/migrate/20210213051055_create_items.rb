class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :category
      t.string :sub_category
      t.text :notes
      t.integer :pantry_max
      t.string :pantry_metric
      t.integer :refrigerate_max
      t.string :refrigerate_metric

      t.timestamps
    end
  end
end
