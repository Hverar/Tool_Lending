class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  validates :score, presence: true, inclusion: { in: 1..5 }
  # validates :user_id, uniqueness: { scope: :tool_id, message: "can only rate once per tool" }
end
