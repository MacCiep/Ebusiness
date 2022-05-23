class CreatePaymentType < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_types do |t|
      t.string :name, null: false, uniqueness: true
      t.timestamps
    end
  end
end
