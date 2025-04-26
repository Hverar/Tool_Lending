class Tool < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings
  validates :name, presence: true
  validates :description, presence: true
end
