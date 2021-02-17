require_relative './application_service'

class RecipeFinder < ApplicationService

  def initialize(tags)
    @tags = tags
  end

  def call
    fetch_search_results.map do |recipe|
      {
        recipe_id: recipe['id'],
        recipe_name: recipe['title'],
        recipe_img_url: recipe['image']
      }
    end
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
end
