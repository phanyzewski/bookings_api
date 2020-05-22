class Vehicle < ApplicationRecord
  belongs_to :account

  validates :vin, presence: true
  validates :year, presence: true
end
