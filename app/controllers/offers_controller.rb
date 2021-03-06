class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :delete, :update]
  before_action :authenticate_user!, only: [:create, :delete, :update]

  def index
    offers = Offer.filter(params.slice(*whitelist_params))
    if params[:start_date] && params[:end_date]
      offers = offers.with_date(params[:start_date], params[:end_date])
    end

    render(json: OfferSerializer.new(offers), status: :ok)
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
    params.require(:offer).permit( :offer_type, :description, :name, :city_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def whitelist_params
    [:with_max_price, :with_city, :with_offer_type, :with_guest_number]
  end
end