class Room < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :offer
  has_many :discounts
  has_many :draft_reservations, dependent: :destroy

  generate_default_numeric_scopes :guests
  scope :with_offer, -> (offer_id) { where(offer_id: offer_id) }
  scope :with_max_price, -> (price) { where("price_per_day <= #{price}") }
  scope :with_guests_number, -> (guests_number) { where("guests <= #{guests_number}") }
  scope :with_tv, -> (tv) { where(tv: tv) }
  scope :with_ac, -> (ac) { where(ac: ac) }
  scope :with_wifi, -> (wifi) { where(wifi: wifi) }
  scope :with_kitchen, -> (kitchen) { where(self_kitchen: kitchen) }
  scope :with_bathroom, -> (bathroom) { where(self_bathroom: bathroom) }

  scope :with_date, -> (start_date, end_date) do
    rooms_ids = Reservation.where("(start_date BETWEEN '#{start_date}' AND '#{end_date}')
                                    OR (end_date BETWEEN '#{start_date}' AND '#{end_date}')
                                    OR (start_date < '#{start_date}' AND end_date > '#{end_date}')")
                           .distinct(:id)
                           .pluck(:room_id)
    where.not(id: rooms_ids)
  end
end
