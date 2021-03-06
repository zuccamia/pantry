class ShoppingAmount < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :item
end
