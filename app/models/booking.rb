class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  validates :start_date, :end_date, presence: true
  validate :no_overlapping_bookings
  validate :only_one_booking_per_user_tool

  before_validation :set_default_status, on: :create

  private


  def set_default_status
    self.status ||= "pending"
  end

  #not the same date
  def no_overlapping_bookings
    return if start_date.blank? || end_date.blank?

    overlaps = Booking.where(tool_id: tool_id, status: "accepted")
                      .where.not(id: id)
                      .where("start_date <= ? AND end_date >= ?", end_date, start_date)

    if overlaps.exists?
      errors.add(:base, "This tool is already booked during the selected dates.")
    end
  end

  #not 2 bookings for the same user and tool
  def only_one_booking_per_user_tool
    return if start_date.blank? || end_date.blank?

    existing_booking = Booking.where(user_id: user_id, tool_id: tool_id)
                               .where.not(id: id)
                               .where("start_date <= ? AND end_date >= ?", end_date, start_date)

    if existing_booking.exists?
      errors.add(:base, "You already have a booking for this tool.")
    end
  end
end
