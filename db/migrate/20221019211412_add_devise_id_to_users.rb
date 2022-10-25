class AddDeviseIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :devise_id, :string
  end
end
