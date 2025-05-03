class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tools
  has_many :bookings
  has_one_attached :profile_photo

  def owner?
    role == 'owner'
  end

  def consumer?
    role == 'consumer'
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
