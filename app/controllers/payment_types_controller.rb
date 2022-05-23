class PaymentTypesController < ApplicationController
  before_action :set_payment_type, only: [:destroy]

  def index
    render json: PaymentType.all
  end

  def create
    new_payment_type = PaymentType.new(payment_type_params)
    if new_payment_type.save
      render json: new_payment_type
    else
      render json: new_payment_type.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @payment_type.delete
      render status: :ok
    else
      render json: @payment_type.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def payment_type_params
    params.require(:payment_type).permit(:name)
  end

  def set_payment_type
    @payment_type = PaymentType.find(params[:id])
  end
end
