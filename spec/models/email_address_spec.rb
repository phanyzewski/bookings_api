require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  subject { FactoryBot.create(:email_address) }

  it { should belong_to(:identity) }

  it { is_expected.to validate_presence_of(:email) }
end
