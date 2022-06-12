class Offer < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :user
  has_many :rooms, dependent: :destroy
  belongs_to :city

  enum offer_type: {
    0 => :private_room,
    1 => :shared_room,
    2 => :hotel_room,
    3 => :entire_place
  }

  generate_default_numeric_scopes :price
  scope :with_city, -> (city) { where(city: city) }

end
