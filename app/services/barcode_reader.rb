require_relative './application_service'
require 'openfoodfacts'

class BarcodeReader < ApplicationService

  def initialize(upc)
    @upc = upc
  end
  
  def call
    # return a hash of product info
    product = Openfoodfacts::Product.get(@upc, locale: 'jp')
    if product
      item_name = product.product_name
      category_name = product.categories.split(',').first # openfoodfacts record categories as a string of a category list
    
      create_item(item_name, category_name)
    else
      "Not found"
    end
  end

  private

  def create_item(item_name, category_name)      # check if item already exists in item database, if not create new
    if Item.exists?(item_name: item_name)
      item = Item.where(item_name: item_name).first
    else
      category = find_category(category_name)   # check if a category already exists in the database, if not create new
      item = Item.new(item_name: item_name)
      item.category = category
      item.save
    end
    item
  end

  def find_category(category_name)
    if Category.exists?(main_category: category_name)
      category = Category.where(main_category: category_name).first
    else
      category = Category.create(main_category: category_name)
    end
    category
  end
end
