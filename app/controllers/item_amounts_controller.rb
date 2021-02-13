class ItemAmountsController < ApplicationController
  def index
    @item_amounts = ItemAmount.all
  end

  def edit
    @item_amount = ItemAmount.find(params[:id])
  end
end
