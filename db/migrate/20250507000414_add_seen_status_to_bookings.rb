class AddSeenStatusToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :seen_status, :boolean
  end
end
