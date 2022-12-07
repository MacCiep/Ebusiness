class CreditCardData < ApplicationRecord
  self.table_name = 'credit_card_datas'

  belongs_to :user
end
