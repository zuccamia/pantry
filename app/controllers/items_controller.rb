class ItemsController < ApplicationController
  def index
    @items = Items.all
  end
end
