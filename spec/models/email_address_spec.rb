require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  subject { FactoryBot.build(:email_address) }

  it { should belong_to(:identity) }

  it { is_expected.to validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
end
