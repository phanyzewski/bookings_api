class Telephone < ApplicationRecord
  belongs_to :identity

  enum phone_type: { mobile: 'mobile', office: 'office', home: 'home', other: 'other' }
end
