class City < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, uniqueness: true
end