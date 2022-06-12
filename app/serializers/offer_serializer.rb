class OfferSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :offer_type

  belongs_to :city
end
