class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :destroy, :update]
  before_action :authenticate_user!, only: [:create, :destroy, :update]

  def index
    render(json: Room.filter(params.slice(*whitelist_params)), status: :ok)
  end

  def show
    render(json: @room, status: :ok)
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      FirstMailMailer.first_mail(current_user).deliver_now
      render(status: :ok)
    else
      render(json: room.errors.full_messages, status: :bad_request)
    end
  end

  def update
    if @room.update(room_params)
      render(status: :ok)
    else
      render(json: room.errors.full_messages, status: :bad_request)
    end
  end

  def destroy
    if @room.destroy
      render(status: :ok)
    else
      render(json: room.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def room_params
    params.require(:room).permit( :offer_id, :guests, :price_per_day, :self_kitchen, :self_kitchen, :tv, :wifi, :ac)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def whitelist_params
    [:with_guests_eq]
  end
end
