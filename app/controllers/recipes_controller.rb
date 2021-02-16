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
    @recipes = RecipeParser.new(params[:tags]).recipe_list
  end

  def import
    RecipeParser.import(params[:recipe_id])
  end
end
