class Offer < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :user
  has_many :rooms, dependent: :destroy

  generate_default_numeric_scopes :price
end
