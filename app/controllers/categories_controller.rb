class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @item_amounts = Item_amount.new
  end


  def category_params
    params.require(:category).permit(:main_category, :sub_category)
  end
end
