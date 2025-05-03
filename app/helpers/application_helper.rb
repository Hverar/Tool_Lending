module ApplicationHelper
  def can_rate?(tool)
    Booking.exists?(user: current_user, tool: tool, status: 'completed') &&
    !Rating.exists?(user: current_user, tool: tool)
  end
end
