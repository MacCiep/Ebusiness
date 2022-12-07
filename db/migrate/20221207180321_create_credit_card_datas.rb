class CreateCreditCardDatas < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_card_datas do |t|
      t.references :user, null: false
      t.string :number, null: false
      t.integer :year, null:false, min: 2022, max: 4096
      t.integer :month, null:false, min: 1, max: 12
      t.string :cvv, null:false, max: 3
      t.timestamps
    end
  end
end
