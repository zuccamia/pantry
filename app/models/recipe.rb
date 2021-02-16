class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_amounts, dependent: :destroy
  has_many :items, through: :recipe_amounts

  validates :recipe_name, presence: true, length: { minimum: 5 }
  acts_as_taggable_on :tags
end
