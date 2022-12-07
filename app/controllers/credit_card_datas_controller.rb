class CreditCardDatasController < ApplicationController
  before_action :authenticate_user!

  def create
    byebug
    credit_card_data = current_user.build_credit_card_data(credit_card_data_params)
    if credit_card_data.save
      render json: credit_card_data, status: :created
    else
      render json: { error: credit_card_data.error.full_messages }, status: :bad_request
    end
  end

  def update
    if current_user.credit_card_data.update(credit_card_data_params)
      render json: current_user.credit_card_data, status: :created
    else
      render json: { error: current_user.credit_card_data.error.full_messages }, status: :bad_request
    end
  end

  def show
    if current_user.credit_card_data.present?
      render json: current_user.credit_card_data
    else
      render status: :not_found
    end
  end

  private

  def credit_card_data_params
    params.require(:credit_card_data).permit(:number, :year, :month, :cvv)
  end
end
