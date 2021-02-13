class CreateItemAmounts < ActiveRecord::Migration[6.1]
  def change
    create_table :item_amounts do |t|
      t.string :description
      t.references :item, null: false, foreign_key: true
      t.date :expiry_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
