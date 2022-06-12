class DraftReservationSerializer
  include JSONAPI::Serializer
  attributes :start_date, :end_date, :room_id

  belongs_to :room, serializer: RoomSerializer

  attribute :number_of_days do |draft_reservation|
    (draft_reservation.end_date - draft_reservation.start_date).to_i
  end

  attribute :price_per_day do |draft_reservation|
    draft_reservation.room.price_per_day
  end

  attribute :room_name do |draft_reservation|
    draft_reservation.room.name
  end

  attribute :final_price do |draft_reservation|
    day_quantity = (draft_reservation.end_date - draft_reservation.start_date).to_i
    day_quantity * draft_reservation.room.price_per_day
  end
end
