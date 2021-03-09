class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :shopping_amounts, dependent: :destroy
  has_many :items, through: :shopping_amounts
  accepts_nested_attributes_for :shopping_amounts, update_only: true
end
