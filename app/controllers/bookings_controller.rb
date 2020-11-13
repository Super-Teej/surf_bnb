class BookingsController < ApplicationController

  def add_index
  end
  
  def new
    @booking = Booking.new
    @surfboard = Surfboard.find(params[:surfboard_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @surfboard = Surfboard.find(params[:surfboard_id])
    @booking.surfboard_id = params[:surfboard_id]
    @booking.user = current_user
    if @booking.save
      redirect_to surfboard_path(@surfboard), notice: 'Your booking was created!'
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to surfboard_path(@booking.surfboard), alert: 'booking canceled'
  end

  private

  def booking_params
    params.require(:booking).permit(:users_id, :booking_id, :start_date, :end_date)
  end
end
