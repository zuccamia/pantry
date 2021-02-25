class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipes = Recipe.tagged_with(params[:tag]) if params[:tag].present?
    @tag = params[:tag]
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.save

    redirect_to recipe_path(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  def search
    @recipes = RecipeFinder.call(params[:tag])
    # return a search result array @recipes of recipe hashes with Spoonacular ID, recipe title and image url as keys
  end

  def view
    @recipe = RecipeParser.call(params[:recipe_id])
    # return a @recipe hash with Spoonacular ID, name, summary, image url, array of ingredients and array of instructions as keys
  end

  def import
    @recipe = RecipeParser.call(params[:recipe_id])
    @user = current_user
    # unable to use current_user in service object so need to assign to @user variable here

    # create a new Recipe object and its recipe amounts when user clicks on `Save` after viewing a recipe
    RecipeImporter.call(@recipe, @user)

    redirect_to recipes_path
    # to see the imported recipe added to my recipes
  end

  private

  def recipe_params
    params.require(:recipe).permit(:tag_list, :recipe_name, :summary, :instructions, :photo)
  end
end
