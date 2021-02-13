class ItemAmountsController < ApplicationController
  def index
    @item_amounts = ItemAmount.all
  end

  def edit
    @item_amount = ItemAmount.find(params[:id])
  end

  def update
    @item_amount = ItemAmount.find(params[:id])
    @item_amount.update(item_amount_params)
    redirect_to item_amount_path(@item_amount)
  end

  private

  def item_amount_params
    params.require(:item_amount).permit(:description, :expiry_date)
  end
end
