class AddExternalIdToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :external_id, :string
  end
end
