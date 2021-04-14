class RecipeAmountsController < ApplicationController
  def index
    @recipe_amounts = RecipeAmount.all
    @recipe_amounts = policy_scope(RecipeAmount)
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_amount = RecipeAmount.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_amount = RecipeAmount.new(recipe_amount_params)
    @recipe_amount.recipe = @recipe
    @recipe_amount.save
    redirect_to recipe_path(@recipe)
    authorize @recipe
  end

  # def edit
  #   @recipe = Recipe.find(params[:recipe_id])
  #   @recipe_amount = RecipeAmount.find(params[:id])
  # end

  # def update
  #   @recipe = Recipe.find(params[:recipe_id])
  #   @recipe_amount = RecipeAmount.find(params[:id])
  #   @recipe_amount.update(recipe_amount_params)
  #   redirect_to recipe_path(@recipe)
  # end

  def destroy
    @recipe_amount = RecipeAmount.find(params[:id])
    @recipe = @recipe_amount.recipe
    @recipe_amount.destroy
    redirect_to recipe_path(@recipe)
    authorize @recipe
  end

  private

  def recipe_amount_params
    params.require(:recipe_amount).permit(:description, :item_id, :recipe_id)
  end
end
