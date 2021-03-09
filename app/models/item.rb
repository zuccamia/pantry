class Item < ApplicationRecord
  has_many :recipe_amounts, dependent: :destroy
  has_many :item_amounts, dependent: :destroy
  belongs_to :category

  validates :item_name, presence: true, length: { minimum: 2 }
end
