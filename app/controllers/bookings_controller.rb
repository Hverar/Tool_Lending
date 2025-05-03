class BookingsController < ApplicationController
  before_action :set_tool, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def accept
    booking = Booking.find(params[:id])
    booking.update(status: "accepted")
    redirect_back fallback_location: user_tools_path, notice: "Booking accepted."
  end

  def decline
    booking = Booking.find(params[:id])
    booking.update(status: "declined")
    redirect_back fallback_location: user_tools_path, alert: "Booking declined."
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.tool.user == current_user
      if @booking.update(status: params[:status])
        redirect_to user_tools_path, notice: "Booking was #{params[:status]}!"
      else
        redirect_to user_tools_path, alert: "Update failed."
      end
    else
      redirect_to root_path, alert: "Unauthorized."
    end
  end

  def my_bookings
    @bookings = current_user.bookings.includes(:tool)
  end


  def create
    @booking = Booking.new(booking_params)
    @booking.tool = @tool
    @booking.user = current_user  # assumes you have user authentication like Devise!

    if @tool.user == current_user
      flash[:alert] = "You cannot book your own tool."
      return redirect_to tool_path(@tool)
    end


    if @booking.save
      redirect_to tool_path(@tool), notice: 'Booking was successfully created.'
    else
      @booking = Booking.new
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    tool = @booking.tool

    if @booking.user == current_user
      @booking.destroy
      redirect_to tool_path(tool), notice: 'Booking was successfully deleted.'
    else
      redirect_to root_path, alert: 'Unauthorized.'
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
