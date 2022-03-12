class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.belongs_to :offers, index: true, foreign_keys: true
      t.numeric :guests
      t.numeric :price_per_day
      t.boolean :self_kitchen
      t.boolean :self_bathroom
      t.boolean :tv
      t.boolean :wifi
      t.boolean :ac
      t.timestamps
    end
  end
end
