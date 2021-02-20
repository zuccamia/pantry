class ItemAmountsController < ApplicationController
  def index
    @item_amounts = ItemAmount.all
    @categories = Category.all
    @items = Item.all
    @recipes = Recipe.all
  end

  def edit
    @item_amount = ItemAmount.find(params[:id])
  end

  def update
    @item_amount = ItemAmount.find(params[:id])
    @item_amount.update(item_amount_params)
    redirect_to item_amounts_path
  end

  private

  def item_amount_params
    params.require(:item_amount).permit(:description, :expiry_date)
  end
end
