class LinebotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: [ :call_back ]
  
  def shopping_list
    shopping_list = ShoppingList.new
    shopping_list.user = current_user
    shopping_list.save

    shopping_amounts = params[:shopping_list].map do |item_id|
      recipe_amount = RecipeAmount.find(item_id.to_i)
      shopping_amount = ShoppingAmount.new(description: recipe_amount.description, item_id: recipe_amount.item.id)
      shopping_amount.shopping_list = shopping_list
      shopping_amount.save
    end

    LinebotShareJob.perform_now(shopping_list)

    redirect_to recipes_path, notice: "Successfully shared your shopping list to your LINE group!"
  end

  def call_back
    LinebotAddToListJob.perform_now()
  end
end
