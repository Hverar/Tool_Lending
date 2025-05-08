class Tool < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings
  has_many :ratings

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? && obj.address_changed? }


  validates :name, presence: true
  validates :description, presence: true

  def average_rating
    ratings.average(:value)&.round(1) || "No ratings yet"
  end

end
