class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :room, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.numeric :price
      t.timestamps
    end
  end
end
