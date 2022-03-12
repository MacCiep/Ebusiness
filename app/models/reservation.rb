class Reservation < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :room
  belongs_to :user

  scope "with_start_from", -> (param) { where("start_date >= '#{param}'")}
  scope "with_end_to", -> (param) { where("end_date <= '#{param}'")}
end
