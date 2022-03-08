class Offer < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :user

  generate_default_numeric_scopes :price
end
