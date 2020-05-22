class Booking < ApplicationRecord
  belongs_to :account
  belongs_to :vehicle

  validates :start_time, presence: true
  validates :duration, presence: true
end
