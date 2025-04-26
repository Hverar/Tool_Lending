class BookingsController < ApplicationController
  before_action :set_tool, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.tool = @tool
    @booking.user = current_user # assumes you have user authentication like Devise!

    if @booking.save
      redirect_to tool_path(@tool), notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
