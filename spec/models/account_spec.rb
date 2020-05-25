require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { FactoryBot.create(:account) }

  it { is_expected.to have_many(:vehicles) }
  it { is_expected.to have_many(:identities) }
  it { is_expected.to have_many(:bookings) }
end
