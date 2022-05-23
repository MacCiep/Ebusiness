class DraftReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft_reservation, only: [:show, :destroy]


  def index
    render json: DraftReservation.all
  end

  def user_scope
    draft_reservations = current_user.draft_reservations
    render json: draft_reservations
  end

  def show
    render json: @draft_reservation
  end

  def destroy
    if @draft_reservation.delete
      render status: :ok
    else
      render json: @draft_reservation.errors.full_messages, status: :unprocessable_entity
    end
  end

  def create
    new_draft_reservation = current_user.draft_reservations.build(draft_reservation_params)d
    if new_draft_reservation.save
      render json: new_draft_reservation, status: :created
    else
      render json: new_draft_reservation.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_draft_reservation
    @draft_reservation = DraftReservation.find(params[:id])
  end

  def draft_reservation_params
    params.require(:draft_reservations).permit(:room_id, :start_date, :end_date)
  end
end
