class BookingsController < ApplicationController
  before_action :set_tool, only: [:new, :create]

  def new
    @booking = Booking.new
  end

<<<<<<< HEAD
  def update
    @booking = Booking.find(params[:id])

    if @booking.tool.user == current_user
      if @booking.update(status: params[:status])
        redirect_to user_tools_path, notice: "Booking #{params[:status]}!"
      else
        redirect_to user_tools_path, alert: "Update failed."
      end
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end


  def create
    @booking = Booking.new(booking_params)
    @booking.tool = @tool
    @booking.user = current_user  # assumes you have user authentication like Devise!

=======
  def create
    @booking = Booking.new(booking_params)
    @booking.tool = @tool
    @booking.user = current_user # assumes you have user authentication like Devise!

>>>>>>> e9a0b8180bd49514e2473402c7a85ecfd3f58d05
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
