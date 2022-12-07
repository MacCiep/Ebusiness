class AddStripeIdToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :stripe_id, :string
  end
end
