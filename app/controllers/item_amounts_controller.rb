class ItemAmountsController < ApplicationController
  def index
    @categories = filtered_categories
    @item_amounts = ItemAmount.all
    @expiring_items = @item_amounts.filter { |item_amount| item_amount.expired? }
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
    set_expiry_date(@item_amount) unless @item_amount.expiry_date.present?

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

  def destroy
    @item_amount = ItemAmount.find(params[:id])
    @item_amount.destroy
    redirect_to item_amounts_path
  end

  def scan_barcode
    render 'scan_barcode'
  end

  def new_barcode_item
    @item_amount = ItemAmount.new
    @item = BarcodeReader.call(params[:upc])
    if @item == "Not found"
      flash.now[:alert] = "Sorry, this product is not yet registered in our database"
      render 'new'
    end
  end

  private

  def item_amount_params
    params.require(:item_amount).permit(:description, :expiry_date, :item_id)
  end

  def set_expiry_date(item_amount)
    shelf_life_max = item_amount.item.pantry_max.nil? ? item_amount.item.refrigerate_max : item_amount.item.pantry_max
    shelf_life_metric = item_amount.item.pantry_metric.nil? ? item_amount.item.refrigerate_metric : item_amount.item.pantry_metric

    expiry_date = item_amount.created_at.to_date + days_converter(shelf_life_max, shelf_life_metric)
    item_amount.update(expiry_date: expiry_date)
  end

  def days_converter(number, duration)

    case duration.downcase
    when 'hours' || 'hour'
      number.hours.in_days
    when 'weeks' || 'week'
      number.weeks.in_days
    when 'months' || 'month'
      number.months.in_days
    when 'years' || 'year'
      number.years.in_days
    when 'indefinitely'
      5.years.in_days
    else
      number
    end

  end

  def filtered_categories
    categories = Category.all.filter do |category|
      category.item_amounts.any?
    end
  end
end
