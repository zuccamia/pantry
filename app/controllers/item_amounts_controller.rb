class ItemAmountsController < ApplicationController
  def index
    @categories = filtered_categories
    @item_amounts = {}
    @categories.each do |category|
      category_name = category.sub_category.nil? ? category.main_category : category.sub_category
      @item_amounts[category_name] =  category.item_amounts
    end
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

  def filtered_categories
    categories = Category.all.filter do |category|
      category.item_amounts.any?
    end
  end
end
