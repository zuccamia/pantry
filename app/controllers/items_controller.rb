class ItemsController < ApplicationController
  def index
    @items = Item.all
    @items = policy_scope(Item)
  end
end
