class AddPaymentTypeToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations,:payment_type, index:false, null: false
  end
end
