class RoomSerializer
  include JSONAPI::Serializer
  attributes :guests, :price_per_day

  belongs_to :offer
end
