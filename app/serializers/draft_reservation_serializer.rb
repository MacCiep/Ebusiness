class DraftReservationSerializer
  include JSONAPI::Serializer
  attributes :start_date, :end_date, :room_id

  belongs_to :room, serializer: RoomSerializer

  attribute :final_price do |draft_reservation|
    day_quantity = (draft_reservation.end_date - draft_reservation.start_date).to_i
    day_quantity * draft_reservation.room.price_per_day
  end
end
