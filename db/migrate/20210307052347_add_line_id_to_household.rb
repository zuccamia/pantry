class AddLineIdToHousehold < ActiveRecord::Migration[6.1]
  def change
    add_column :households, :line_id, :string
  end
end
