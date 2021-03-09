require_relative './application_service'

class RecipeFinder < ApplicationService

  def initialize(tag)
    @tag = tag
  end

  def call
    fetch_search_results.map do |recipe|
      {
        id: recipe['id'],
        name: recipe['title'],
        summary: get_summary(recipe['id']),
        img_url: recipe['image']
      }
    end
  end

  private

  def fetch_search_results
    result_number = 10
    search_url = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{@tag}&number=#{result_number}&apiKey=#{api_key}"
    results = JSON.parse(URI.open(search_url).read)

    # filter results with instructions only
    results.filter do |recipe|
      instruction_url = "https://api.spoonacular.com/recipes/#{recipe['id']}/analyzedInstructions?apiKey=#{api_key}"
      instructions = JSON.parse(URI.open(instruction_url).read)
      instructions.any?
    end
  end

  def get_summary(recipe_id)
    summary_url = "https://api.spoonacular.com/recipes/#{recipe_id}/summary?apiKey=#{api_key}"
    summary = JSON.parse(URI.open(summary_url).read)['summary']
  end
end
