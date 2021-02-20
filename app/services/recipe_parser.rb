require_relative './application_service'

class RecipeParser < ApplicationService

  def initialize(recipe_id)
    @recipe_id = recipe_id
  end

  def call
    info_url = "https://api.spoonacular.com/recipes/#{@recipe_id}/information?apiKey=#{api_key}"
    info = JSON.parse(URI.open(info_url).read)

    # return a hash of recipe information
    {
      id: info['id'],
      name: info['title'],
      summary: info['summary'],
      img_url: info['image'],
      ingredients: parse_ingredients(info['extendedIngredients']),
      instructions: parse_instructions(info['analyzedInstructions'].first['steps'])
    }
  end

  private
  
  def parse_ingredients(ingredients)
    ingredients.map do |ingredient|
      {
        name: ingredient['name'].capitalize,
        description: "#{ingredient['original']}",
        category: ingredient['aisle']
      }
    end
  end

  def parse_instructions(instructions)
    instructions.map do |step|
      "#{step['number']}. #{step['step']}"
    end
  end
end
