class ItemAmount < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :description, presence: true, length: { minimum: 2 }
  validate :expiry_date_is_after_created_date

  def expiry_date_is_after_created_date
    return if expiry_date.blank?

    if expiry_date < Date.today
      errors.add(:expiry_date, "cannot be before today. Are you sure to add this to the pantry?")
    end
  end
end
