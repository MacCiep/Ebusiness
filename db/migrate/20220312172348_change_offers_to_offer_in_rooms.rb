class ChangeOffersToOfferInRooms < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :offers_id, :offer_id
  end
end
