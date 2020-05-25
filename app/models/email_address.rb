class EmailAddress < ApplicationRecord
  belongs_to :identity

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
