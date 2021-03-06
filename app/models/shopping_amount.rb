class ShoppingAmount < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :item

  validates :description, presence: true, length: { minimum: 2 }
end
