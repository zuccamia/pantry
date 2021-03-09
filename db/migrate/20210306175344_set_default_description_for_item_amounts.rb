class SetDefaultDescriptionForItemAmounts < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:item_amounts, :description, '1 unit')
  end
end
