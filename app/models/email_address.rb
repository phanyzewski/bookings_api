class EmailAddress < ApplicationRecord
  belongs_to :identity

  validates_uniqueness_of :email, case_sensitive: false
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

end
