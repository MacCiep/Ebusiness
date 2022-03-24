class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :delete, :update]
  before_action :authenticate_user!, only: [:create, :delete, :update]

  def index
    render(json: Offer.filter(params.slice(*whitelist_params)), status: :ok)
  end

  def show
    render(json: @offer, status: :ok)
  end

  def create
    @offer = current_user.offers.new(offers_params)
    UserNotifierMailer.send_signup_email(current_user).deliver_now
    if @offer.save
      render(status: :ok)
    else
      render(json: @offer.errors.full_messages, status: :bad_request)
    end
  end

  def update
    if @offer.update(offers_params)
      render(status: :ok)
    else
      render(json: @offer.errors.full_messages, status: :bad_request)
    end
  end

  def destroy
    if @offer.destroy
      render(status: :ok)
    else
      render(json: @offer.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def offers_params
    params.require(:offer).permit( :price, :available_places)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def whitelist_params
    [:with_price_min, :with_price_max]
  end
end