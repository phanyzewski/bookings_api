class Identity < ApplicationRecord
  belongs_to :account
  has_many :email_addresses
  has_many :telephones

  validates :first_name, presence: true
  validates :last_name, presence: true
end
