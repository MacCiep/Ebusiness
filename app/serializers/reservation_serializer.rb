class ReservationSerializer
  include JSONAPI::Serializer
  attributes :start_date, :end_date, :price
  belongs_to :room
  belongs_to :payment_type, serializer: PaymentTypeSerializer

  attribute :purchase_date do |reservation|
    reservation.created_at
  end
end
