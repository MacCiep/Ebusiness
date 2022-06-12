class DraftReservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :max_number_of_records_per_user

  def max_number_of_records_per_user
    if DraftReservation.where(user_id: user_id).size == 10
      errors.add(:user_id, "User cannot have more than 10 draft reservations")
    end
  end
end
