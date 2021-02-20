class Category < ApplicationRecord
  has_many :items
  has_many :item_amounts, through: :items

  validates :main_category, presence: true
end
