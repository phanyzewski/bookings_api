class Identity < ApplicationRecord
  belongs_to :account
  has_many :email_addresses, dependent: :destroy
  has_many :telephones, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
end
