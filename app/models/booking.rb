class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tool, dependent: :destroy

  validates :start_date, :end_date, presence: true

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "pending"
  end
end
