require 'csv'

category_text = File.read(Rails.root.join('lib', 'seeds', 'categories.csv'))
category_csv = CSV.parse(category_text, headers: true)

ingredient_text = File.read(Rails.root.join('lib', 'seeds', 'ingredients.csv'))
ingredient_csv = CSV.parse(ingredient_text, headers: true)
