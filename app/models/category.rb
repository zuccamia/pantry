class Category < ApplicationRecord
  has_many :items

  validates :main_category, presence: true
end
