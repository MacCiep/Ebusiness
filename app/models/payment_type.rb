class PaymentType < ApplicationRecord
  validates_uniqueness_of :name
end
