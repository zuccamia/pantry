class RecipeAmount < ApplicationRecord
  belongs_to :item
  belongs_to :recipe

  validates :description, presence: true, length: { minimum: 2 }
end
