class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      # Handle payment with Stripe here
      redirect_to @booking.service, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def on_going
    @on_going_bookings = current_user.bookings.on_going
  end

  def completed
    @completed_bookings = current_user.bookings.completed
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :service_id, :additional_parameter)
  end
end
