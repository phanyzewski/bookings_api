class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]

  # GET /vehicles
  def index
    @vehicles = Vehicle.all

    render jsonapi: @vehicles
  end

  # GET /vehicles/1
  def show
    render jsonapi: @vehicle
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render jsonapi: @vehicle, status: :created, location: @vehicle
    else
      render jsonapi_errors: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicles/1
  def update
    if @vehicle.update(vehicle_params)
      render jsonapi: @vehicle
    else
      render jsonapi_errors: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.require(:vehicle).permit(:vin, :year, :account_id, :make, :model, :color)
    end
end
