class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy, :update]
  before_action :authenticate_user!, only: [:create, :destroy, :update]

  def index
    render(json: Reservation.filter(params.slice(*whitelist_params)), status: :ok)
  end

  def show
    render(json: @reservation, status: :ok)
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    Reservation.reservation_mapper(@reservation, DraftReservation.find(params[:reservation][:draft_reservation_id]))
    if @reservation.save
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

  def reservation_params
    params.require(:reservation).permit( :payment_type_id, :price)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def whitelist_params
    [:with_start_from, :with_end_to]
  end
end
