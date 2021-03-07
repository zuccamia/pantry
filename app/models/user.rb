class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :household, optional: true
  has_many :recipes
  has_many :shopping_lists
  has_many :item_amounts, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  has_one_attached :photo

  # Uncomment to update line_id for previously saved users without photos
  # validates :photo, presence: true
end
