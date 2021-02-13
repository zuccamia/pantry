class Recipe < ApplicationRecord
  belongs_to :user

  validates :recipe_name, presence: true, length: { minimum: 5 }
end
