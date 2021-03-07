class RecipeAmount < ApplicationRecord
  belongs_to :item
  belongs_to :recipe, optional: true
  validates_presence_of :recipe

  validates :description, presence: true, length: { minimum: 2 }
end
