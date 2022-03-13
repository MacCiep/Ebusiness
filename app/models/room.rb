class Room < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :offer
  has_many :discounts

  generate_default_numeric_scopes :guests
end
