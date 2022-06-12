class ReservationSerializer
  include JSONAPI::Serializer
  attributes :start_date, :end_date, :price
  belongs_to :room
  belongs_to :payment_type, serializer: PaymentTypeSerializer

  attribute :number_of_days do |reservation|
    (reservation.end_date -  reservation.start_date).to_i
  end

  attribute :price_per_day do |reservation|
    reservation.room.price_per_day
  end

  attribute :payment_type do |reservation|
    reservation.payment_type.name
  end

  attribute :room_name do |reservation|
    reservation.room.name
  end

  attribute :purchase_date do |reservation|
    reservation.created_at
  end
end
