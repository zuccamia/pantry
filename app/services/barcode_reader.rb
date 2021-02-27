require_relative './application_service'
require 'openfoodfacts'

class BarcodeReader < ApplicationService

  def initialize(upc)
    @upc = upc
  end
  
  def call
    # return a hash of product info
    product = Openfoodfacts::Product.get(@upc, locale: 'jp')
    {
      item_name: product.product_name,
      main_category: product.categories.split(',').first # openfoodfacts record categories as a string of a category list
    }
  end
end
