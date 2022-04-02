class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :destroy, :update]
  def index
    render json: City.all, status: :ok
  end

  def show
    if @city
      render json: @city, status: :ok
    else
      render json: @city.errors.full_messages, status: :not_found
    end
  end

  def destroy
    if @city.delete
      render status: :ok
    else
      render json: @city.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @city.delete
      render status: :ok
    else
      render json: @city.errors.full_messages, status: :unprocessable_entity
    end
  end

  def create
    new_city = City.new(cities_params)
    if new_city.save
      render json: new_city, status: :ok
    else
      render json: new_city.errors.full_messages, status: :unprocessable_entity
    end
  end


  def cities_params
    params.require(:city).permit(:name)
  end

  def set_city
    @city = City.find(params[:id])
  end
end
