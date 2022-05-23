class DraftReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft_reservation, only: [:show, :destroy]


  def index
    records = DraftReservation.all
    render json: serialize_records(records)
  end

  def user_scope
    draft_reservations = current_user.draft_reservations
    render json: serialize_records(draft_reservations)
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
    new_draft_reservation = current_user.draft_reservations.build(draft_reservation_params)
    if new_draft_reservation.save
      render json: DraftReservationSerializer.new(new_draft_reservation).serializable_hash.to_json, status: :created
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

  def serialize_records(records)
    records = records.includes(room: [:offer])
    options = {}
    options[:include] = %i(room room.offer)
    DraftReservationSerializer.new(records, options).serializable_hash.to_json
  end
end
