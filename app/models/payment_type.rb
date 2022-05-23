class PaymentType < ApplicationRecord
  has_many :reservations

  validates_uniqueness_of :name
end
