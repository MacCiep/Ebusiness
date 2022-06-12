class AddBreakfastToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :breakfast, :boolean, default: false
  end
end
