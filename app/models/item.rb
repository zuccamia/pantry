class Item < ApplicationRecord
  has_many :item_amounts, dependent: :destroy
end
