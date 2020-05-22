class Booking < ApplicationRecord
  belongs_to :account
  belongs_to :vehicle
end
