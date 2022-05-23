class Reservation < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :room
  belongs_to :user

  scope "with_start_from", -> (param) { where("start_date >= '#{param}'")}
  scope "with_end_to", -> (param) { where("end_date <= '#{param}'")}

  def self.reservation_mapper(reservation, draft_reservation)
    omit_fields = %i(id created_at updated_at price)

    Reservation.attribute_names.each do |attr_name|
      next unless draft_reservation.respond_to?(attr_name) && !omit_fields.include?(attr_name)
      reservation[attr_name] = draft_reservation[attr_name]
    end
  end

end
