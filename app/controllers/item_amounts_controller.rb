class ItemAmountsController < ApplicationController
  def index
    @item_amounts = ItemAmount.all
  end
end
