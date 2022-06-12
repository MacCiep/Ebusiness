class AddNameToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :name, :text, null: false
  end
end
