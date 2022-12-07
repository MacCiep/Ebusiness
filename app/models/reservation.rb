class Reservation < ApplicationRecord
  include Filterable, HasGenericScopes
  belongs_to :room
  belongs_to :user
  belongs_to :payment_type

  scope "with_start_from", -> (param) { where("start_date >= '#{param}'")}
  scope "with_end_to", -> (param) { where("end_date <= '#{param}'")}

  def self.reservation_mapper(reservation, draft_reservation)
    omit_fields = %i(id created_at updated_at price)

    Reservation.attribute_names.each do |attr_name|
      next unless draft_reservation.respond_to?(attr_name) && !omit_fields.include?(attr_name)
      reservation[attr_name] = draft_reservation[attr_name]
    end
  end

  def create_on_stripe(card)
    token = get_stripe_token(card)
    params = { amount: price.to_i, currency: 'usd', source: token }
    response = Stripe::Charge.create(params)
    self.stripe_id = response.id
  end

  private

  def get_stripe_token(card)
    Stripe::Token.create({
                           card: {
                             number: card.number,
                             exp_month: card.month,
                             exp_year: card.year,
                             cvc: card.cvv,
                           }
                         })
  end

  def create_payment
    params = {
      order_id: id,
      credit_card_number: credit_card_number,
      credit_card_exp_month: creadit_card_exp_month,
      creadit_card_exp_year: creadit_card_exp_year,
      credit_card_cvv: creadit_card_cvv
    }
  end

end
