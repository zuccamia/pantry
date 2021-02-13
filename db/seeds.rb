require 'csv'

def seed_categories
  category_text = File.read(Rails.root.join('lib', 'seeds', 'categories.csv'))
  category_csv = CSV.parse(category_text, headers: true)
  
  category_csv.each do |row|
    Category.create(
      main_category: row[0],
      sub_category: row[1]
    )
  end
end

def seed_items
  item_text = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
  item_csv = CSV.parse(item_text, headers: true)
  
  item_csv.each do |row|
    item = Item.create(
      category_id: row[0],
      item_name: row[1],
      notes: row[2],
      pantry_max: row[9].nil? ? row[5] : row[9],
      pantry_metric: row[10].nil? ? row[6] : row[10],
      refrigerate_max: row[16].nil? ? row[20] : row[16],
      refrigerate_metric: row[17].nil? ? row[21] : row[17]
    )
    item.save
    puts "Created #{item.item_name}"
  end
end

puts "Cleaning database..."
Item.destroy_all
Category.destroy_all
ItemAmount.destroy_all
Recipe.destroy_all
RecipeAmount.destroy_all

puts "Seeding database..."
seed_categories
puts "Created #{Category.all.count} categories"

seed_items
puts "Created #{Item.all.count} items"
