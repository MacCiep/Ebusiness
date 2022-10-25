class OfferSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :offer_type

  attribute :latitude do |_latitude|
    rand(-90.000000..90.000000).round(6)
  end

  attribute :longitude do |_longitude|
    rand(-90.000000..90.000000).round(6)
  end

  belongs_to :city
end
