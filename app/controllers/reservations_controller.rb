class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy, :update]
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  rescue_from Stripe::CardError, :with => :card_error

  def index
    records = Reservation.filter(params.slice(*whitelist_params))
    render(json: serialize_records(records), status: :ok)
  end

  def show_user_scope
    records = current_user.reservations
    render(json: serialize_records(records), status: :ok)
  end

  def show
    render(json: @reservation, status: :ok)
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    draft_reservation = DraftReservation.find(params[:reservation][:draft_reservation_id])
    Reservation.reservation_mapper(@reservation, draft_reservation)

    if @reservation.payment_type.name == 'card'
      @reservation.create_on_stripe(current_user.credit_card_data)
    end

    byebug
    if @reservation.validate

      draft_reservation.delete

      @reservation.save
      render(json: @reservation, status: :ok)
    else
      render(json: @reservation.errors.full_messages, status: :bad_request)
    end
  end

  def update
    if @reservation.update(reservation_params)
      render(status: :ok)
    else
      render(json: @reservation.errors.full_messages, status: :bad_request)
    end
  end

  def destroy
    if @reservation.destroy
      render(status: :ok)
    else
      render(json: @reservation.errors.full_messages, status: :unprocessable_entity)
    end
  end

  private

  def card_error
    render json: { error: "There was problem with your card!", status: :bad_request }
  end

  def reservation_params
    params.require(:reservation).permit( :payment_type_id, :price)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def whitelist_params
    [:with_start_from, :with_end_to]
  end

  def serialize_records(records)
    records = records.includes(:payment_type, room: [:offer])
    options = {}
    options[:include] = %i(payment_type room room.offer)
    ReservationSerializer.new(records, options).serializable_hash.to_json
  end
end
