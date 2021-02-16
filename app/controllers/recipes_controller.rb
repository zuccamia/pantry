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

  private

  def recipe_params
    params.require(:recipe_name).permit(:tags, :user_id)
  end
end
