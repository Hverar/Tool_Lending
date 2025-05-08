class UsersController < ApplicationController

  def index
    if params[:view] == "offers"
      @bookings = current_user.bookings.order(created_at: :desc)

      # Mark all accepted/declined bookings as seen
      @bookings.where(status: ["accepted", "declined"], seen_status: false).update_all(seen_status: true)
    end
  end

  def show
  end

  def offers
    @bookings = current_user.bookings
    @bookings.where(status: ["accepted", "declined"], seen_status: false).update_all(seen_status: true)
  end
end
