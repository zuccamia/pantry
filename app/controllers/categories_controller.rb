class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.all
    @item_amounts = ItemAmount.all
  end

  def show
    @category = Category.find(params[:id])
    @item_amount = ItemAmount.new
  end

  def category_params
    params.require(:category).permit(:main_category, :sub_category)
  end
end
