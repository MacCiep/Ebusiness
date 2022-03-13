class DiscountController < ApplicationController

  def index
    render(json: Discount.all, status: :ok)
  end

  def show
    Room.find
    render(json: @discount, status: :ok)
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      render(status: :ok)
    else
      render(json: @discount.errors.full_messages, status: :bad_request)
    end
  end

  def update
    if @discount.update(discount_params)
      render(status: :ok)
    else
      render(json: @discount.errors.full_messages, status: :bad_request)
    end
  end

  def destroy
    if @discount.destroy
      render(status: :ok)
    else
      render(json: @discount.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def discount_params
    params.require(:offer).permit( :price, :available_places)
  end

  def set_discount
    @discount = Discount.find(params[:id])
  end
end
