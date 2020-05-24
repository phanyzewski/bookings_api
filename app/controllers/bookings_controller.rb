class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update, :destroy]

  # GET /bookings
  def index
    jsonapi_paginate(Booking.all) do |paginated|
      render jsonapi: paginated
    end
  end

  # GET /bookings/1
  def show
    render jsonapi: @booking
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render jsonapi: @booking, status: :created, location: @booking
    else
      render jsonapi_errors: @booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(booking_params)
      render jsonapi: @booking
    else
      render jsonapi_errors: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def booking_params
      params.require(:booking).permit(:start_time, :duration, :details, :account_id, :vehicle_id)
    end
end
