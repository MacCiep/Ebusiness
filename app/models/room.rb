class Room < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :offer
  has_many :discounts
  has_many :draft_reservations, dependent: :destroy

  generate_default_numeric_scopes :guests
  scope :with_offer, -> (offer_id) { where(offer_id: offer_id) }
end
