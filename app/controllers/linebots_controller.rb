class LinebotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: [ :call_back ]
  
  def shopping_list
    shopping_list = params[:shopping_list].map do |item_id|
      RecipeAmount.find(item_id.to_i)
    end
    LinebotShareJob.perform_now(shopping_list)

    redirect_to recipes_path, notice: "Successfully shared your shopping list to your LINE group!"
  end

  def call_back
    LinebotAddToListJob.perform_now()
  end
end
