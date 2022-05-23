class Discount < ApplicationRecord
  belongs_to :room

  validates :room_id, uniqueness: true
end
