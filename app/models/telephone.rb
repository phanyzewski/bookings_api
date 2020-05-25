class Telephone < ApplicationRecord
  belongs_to :identity

  validates :phone_number, presence: true
  enum phone_type: { mobile: "mobile", office: "office", home: "home", other: "other" }
end
