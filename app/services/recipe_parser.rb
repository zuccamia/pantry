class RecipeParser
  require 'open-uri'
  require 'json'
  require 'dotenv'
  Dotenv.load

  def initialize(tags)
    @tags = tags
  end

  def recipe_list
    fetch_search_results.map do |recipe|
      {
        recipe_id: recipe['id'],
        recipe_name: recipe['title'],
        recipe_img_url: recipe['image']
      }
    end
  end

  def self.import(recipe_id)
    # save chosen recipe
    recipe = recipe_list.select { |result| result[:recipe_id] == recipe_id }.first
    recipe = Recipe.new(recipe_name: recipe[:recipe_name])
    recipe.user = current_user
    recipe.save

    # add recipe amounts to recipe
    add_ingredients_to(recipe)
  end

  private

  def fetch_search_results
    result_number = 10
    search_url = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{@tags}&number=#{result_number}&apiKey=#{api_key}"
    results = JSON.parse(URI.open(search_url).read)

    # filter results with instructions only
    results.filter do |recipe|
      instruction_url = "https://api.spoonacular.com/recipes/#{recipe['id']}/analyzedInstructions?apiKey=#{api_key}"
      instructions = JSON.parse(URI.open(instruction_url).read)
      instructions.any?
    end
  end

  def add_ingredients_to(recipe)
    ingredient_url = "https://api.spoonacular.com/recipes/#{recipe_id}/ingredientWidget.json?apiKey=#{api_key}"
    ingredients = JSON.parse(URI.open(ingredient_url).read)['ingredients']
    ingredients.each do |ingredient|
      if Item.exist?(item_name: ingredient['name'].capitalize)
        item = Item.where(item_name: ingredient['name'].capitalize)
      else
        item = Item.new(item_name: ingredient['name'].capitalize)
        tmp_category = Category.create(main_category: 'Undecided')
        item.category = tmp_category
        item.save
      end
      recipe_amount = RecipeAmount.new(description: "#{ingredient['amount']['metric']['value']} #{ingredient['amount']['metric']['unit']}")
      recipe_amount.item = item
      recipe_amount.recipe = recipe
      recipe_amount.save
      recipe.tag_list.add(item.item_name)
    end
  end

  def api_key
    ENV['SPOONACULAR']
  end
end

id = (RecipeParser.new(['apple', 'butter']).recipe_list[0][:recipe_id])
p RecipeParser.import(id)
