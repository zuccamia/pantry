require 'csv'

# require 'database_cleaner/active_record'

# DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB
# DatabaseCleaner.clean

def seed_categories
  category_text = File.read(Rails.root.join('lib', 'seeds', 'categories.csv'))
  category_csv = CSV.parse(category_text, headers: true)

  category_csv.each_with_index do |row, index|
    Category.create(
      main_category: row[0],
      sub_category: row[1],
      external_id: index + 1
    )
  end
end

def seed_items
  item_text = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
  item_csv = CSV.parse(item_text, headers: true)

  item_csv.each do |row|
    item = Item.create(
      category_id: Category.where(external_id: row[0]).first.id,
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

def seed_item_amounts
  becky = User.new(first_name: "Rebecca", last_name: "Windsor")
  becky.email = "becky@test.com"
  becky.password = "test123"
  becky.save
  puts "Create user #{becky.first_name}"

  3.times do
    item_amount = ItemAmount.new(description: "#{[20, 50, 70, 100, 150, 200].sample} gram")
    item_amount.item = Category.find_by(external_id: 6).items.sample
    item_amount.user = becky
    item_amount.expiry_date = Date.today.next_year([1, 2, 3].sample)
    item_amount.save
  end

  3.times do
    item_amount = ItemAmount.new(description: "#{(2..7).to_a.sample} cups")
    item_amount.item = Category.find_by(external_id: 19).items.sample
    item_amount.user = becky
    item_amount.save
  end

  2.times do
    item_amount = ItemAmount.new(description: "#{(2..10).to_a.sample} fruits")
    item_amount.item = Category.find_by(external_id: 18).items.sample
    item_amount.user = becky
    item_amount.save
  end
end

puts "Cleaning database..."
Item.destroy_all
Category.destroy_all
ItemAmount.destroy_all
Recipe.destroy_all
RecipeAmount.destroy_all
User.destroy_all

puts "Seeding database..."
seed_categories
puts "Created #{Category.all.count} categories"

seed_items
puts "Created #{Item.all.count} items"

seed_item_amounts
puts "Created #{ItemAmount.all.count} item amounts"
