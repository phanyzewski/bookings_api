class Account < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :bookings, dependent: :destroy

  def self.search_by_email_address(email_address)
    email_addressess = EmailAddress.where(email: email_address)
    identities = Identity.where(id: email_addressess.map(&:identity_id))

    Account.where(id: identities.map(&:account_id))
  end

  def self.search_by_phone_number(phone_number)
    telephone = Telephone.where(phone_number: phone_number)
    identities = Identity.where(id: telephone.map(&:identity_id))

    Account.where(id: identities.map(&:account_id))
  end

  def self.search_by_name(last_name, first_name)
    identities = Identity.where(last_name: last_name, first_name: first_name)

    Account.where(id: identities.map(&:account_id))
  end

  def self.search_by_vin(vin)
    Account.where(id: Vehicle.where(vin: vin).map(&:account_id))
  end
end
