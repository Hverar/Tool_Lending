class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :tool_id, message: "can only rate once per tool" }
  validate :must_have_accepted_booking

  private

  def must_have_accepted_booking
    valid_booking = Booking.exists?(
      user_id: user_id,
      tool_id: tool_id,
      status: "accepted"
    )

    unless valid_booking
      errors.add(:base, "You can only rate a tool after your booking has been accepted.")
    end
  end
end
