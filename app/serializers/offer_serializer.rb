class OfferSerializer
  include JSONAPI::Serializer
  attributes :name, :description

  belongs_to :city
end
