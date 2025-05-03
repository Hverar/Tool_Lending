class Tool < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings
  has_many :ratings

  validates :name, presence: true
  validates :description, presence: true

  def average_rating
    ratings.average(:value)&.round(1) || "No ratings yet"
  end

end
