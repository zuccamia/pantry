class Item < ApplicationRecord
  has_many :recipe_amounts, dependent: :destroy
  has_many :item_amounts, dependent: :destroy

  validates :item_name, presence: true, length: { minimum: 5 }
  validates :category, presence: true
end
