class CreateDraftReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :draft_reservations do |t|
      t.references :user, index: true, null: false
      t.references :room, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
  end
end
