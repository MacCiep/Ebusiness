class Offer < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :user
  has_many :rooms, dependent: :destroy
  belongs_to :city

  generate_default_numeric_scopes :price
  scope :with_city, -> (city) { where(city: city) }
end
