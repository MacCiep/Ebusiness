class AddCitiesIndexToOffers < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :offers, :city, index: true, foreign_key: true
  end
end
