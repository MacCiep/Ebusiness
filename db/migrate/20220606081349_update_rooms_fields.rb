class UpdateRoomsFields < ActiveRecord::Migration[6.1]
  def up
    change_column :rooms, :guests, :integer

    change_column_null :rooms, :guests, false
    change_column_null :rooms, :price_per_day, false
    change_column_null :rooms, :offer_id, false

    change_column_default :rooms, :self_bathroom, false
    change_column_default :rooms, :self_kitchen, false
    change_column_default :rooms, :wifi, false
    change_column_default :rooms, :tv, false
    change_column_default :rooms, :ac, false
    change_column_default :rooms, :wifi, false
  end
  def down
    change_column_default :rooms, :self_bathroom, false
    change_column_default :rooms, :self_kitchen, false
    change_column_default :rooms, :wifi, false
    change_column_default :rooms, :tv, false
    change_column_default :rooms, :ac, false
    change_column_default :rooms, :wifi, false
  end
end
