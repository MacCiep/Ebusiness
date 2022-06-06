class RoomSerializer
  include JSONAPI::Serializer
  attributes :guests, :price_per_day, :tv, :wifi, :ac, :self_kitchen, :self_bathroom

  belongs_to :offer
end
