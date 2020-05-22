require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { FactoryBot.build(:account) }
  it { should have_many(:vehicles)}
  it { should have_many(:identities)}
  it { should have_many(:bookings)}
end
