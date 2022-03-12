class Room < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :offer

  generate_default_numeric_scopes :guests
end
