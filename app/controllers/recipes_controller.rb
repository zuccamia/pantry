class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def search
    @recipes = RecipeFinder.call(params[:tags])
    # return an array of recipe hashes with Spoonacular ID, recipe title and image url as keys
  end

  def import
    RecipeParser.import(@recipes, params[:recipe_id])
  end
end
