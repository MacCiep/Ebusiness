class CreateDiscount < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.belongs_to :room, index: true, foreign_key: true
      t.numeric :price_drop
      t.timestamps
    end
  end
end
