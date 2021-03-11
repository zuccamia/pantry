require_relative './application_service'

class RecipeImporter < ApplicationService
  
  def initialize(recipe, user)
    @recipe = recipe
    @user = user
  end

  def call
    my_recipe = Recipe.new(
      recipe_name: @recipe[:name],
      summary: @recipe[:summary],
      instructions: @recipe[:instructions].join("\n\n"),
      image: @recipe[:img_url]
    )
    my_recipe.user = @user

    add_recipe_amounts(@recipe[:ingredients], my_recipe)
  end

  private

  def add_recipe_amounts(ingredients, recipe)
    ingredients.each do |ingredient|
      recipe_amount = RecipeAmount.new(description: ingredient[:description])
      item = find_item(ingredient[:name], ingredient[:category])
      recipe_amount.item = item
      recipe_amount.recipe = recipe
      recipe_amount.save
      recipe.tag_list.add(item.item_name)
      recipe.save
    end
  end

  def find_item(item_name, category_name)      # check if item already exists in item database, if not create new
    if Item.exists?(item_name: item_name)
      item = Item.where(item_name: item_name).first
    else
      category = find_category(category_name)   # check if a category already exists in the database, if not create new
      item = Item.new(item_name: item_name)
      item.category = category
      item.save
    end
    item
  end

  def find_category(category_name)
    if Category.exists?(main_category: category_name)
      category = Category.where(main_category: category_name).first
    else
      category = Category.create(main_category: category_name)
    end
    category
  end
end
