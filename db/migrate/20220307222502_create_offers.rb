class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.numeric :price, null: false
      t.numeric :available_places, null: false
      t.timestamps
    end
  end
end
