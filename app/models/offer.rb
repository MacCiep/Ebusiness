class Offer < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :user
  has_many :rooms, dependent: :destroy
  belongs_to :city

  enum offer_type: [
    :private_room,
    :shared_room,
    :hotel_room,
    :entire_place
  ]

  generate_default_numeric_scopes :price
  scope :with_offer_type, -> (offer_type) { where(offer_type: offer_type) }
  scope :with_city, -> (city) { where(city_id: city) }
  scope :with_max_price, -> (price) do
    offers_ids = Room.where("price_per_day < #{price}")
                     .distinct(:id)
                     .pluck(:offer_id)

    where(id: offers_ids)
  end

  scope :with_guests_number, -> (guests_number) do
    offers_ids = Room.where(guest: guests_number).pluck(:offer_id)
    where.not(id: offers_ids)
  end

  scope :with_date, -> (start_date, end_date) do
    rooms_ids = Reservation.where("(start_date BETWEEN '#{start_date}' AND '#{end_date}')
                                    OR (end_date BETWEEN '#{start_date}' AND '#{end_date}')
                                    OR (start_date < '#{start_date}' AND end_date > '#{end_date}')")
                           .distinct(:id)
                           .pluck(:room_id)
    offers_ids = Room.where(id: rooms_ids).pluck(:offer_id)
    where.not(id: offers_ids)
  end
end
