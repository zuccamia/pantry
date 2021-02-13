class Item < ApplicationRecord
  validates :item_name, presence: true, length: { minimum: 5 }
  validates :category, presence: true
end
