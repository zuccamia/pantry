class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  belongs_to :household, optional: true
  has_many :recipes
  has_many :shopping_lists
  has_many :item_amounts, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  has_one_attached :photo

  # Uncomment to update line_id for previously saved users without photos
  # validates :photo, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, line_id: auth.uid).first_or_create do |user|
      user.email = "#{auth.uid}.#{auth.provider}@example.com"  
      # Can get user email when we have 
      # a screenshot that shows how your app asks for consent and explains 
      # what you're using the email addresses for.
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[1]
    end
  end

end
