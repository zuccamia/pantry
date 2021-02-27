class ItemAmountsController < ApplicationController
  def index
    @categories = filtered_categories
    @item_amounts = ItemAmount.all
    # @categories.each do |category|
    #   category_name = category.sub_category.nil? ? category.main_category : category.sub_category
    #   @item_amounts[category_name] = category.item_amounts
    # end
    @recipes = Recipe.all
  end

  def new
    @item_amount = ItemAmount.new
  end

  def create
    @item_amount = ItemAmount.new(item_amount_params)
    @item_amount.item = Item.find(params[:item_id].nil? ? params[:item_amount][:item_id] : params[:item_id])
    @item_amount.user = current_user
    @item_amount.save

    redirect_to item_amounts_path
  end

  def edit
    @item_amount = ItemAmount.find(params[:id])
  end

  def update
    @item_amount = ItemAmount.find(params[:id])
    @item_amount.update(item_amount_params)
    redirect_to item_amounts_path
  end

  def scan_barcode
    render 'scan_barcode'
  end

  def new_barcode_item
    @item = BarcodeReader.call(params[:upc])
    render 'new' if @item.nil?
    @item_amount = ItemAmount.new
  end

  private

  def item_amount_params
    params.require(:item_amount).permit(:description, :expiry_date, :item_id)
  end

  def filtered_categories
    categories = Category.all.filter do |category|
      category.item_amounts.any?
    end
  end
end
