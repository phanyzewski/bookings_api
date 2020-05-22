class Account < ApplicationRecord
  has_many :identities
  has_many :vehicles
end
