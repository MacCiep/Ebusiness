class RemoveRedundantFieldsFromOffers < ActiveRecord::Migration[6.1]
  def change
    remove_column :offers, :price
    remove_column :offers, :available_places
    add_column :offers, :name, :string, limit: 60
    add_column :offers, :description, :text, limit: 250
  end
end
