class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_amounts, dependent: :destroy
  has_many :items, through: :recipe_amounts
  accepts_nested_attributes_for :recipe_amounts, allow_destroy: true, update_only: true, reject_if: :all_blank
  validates :recipe_name, presence: true, length: { minimum: 5 }
  acts_as_taggable_on :tags

  has_one_attached :photo

  enum status: {
    private: 0,
    public: 1,
  }, _prefix: true
end
