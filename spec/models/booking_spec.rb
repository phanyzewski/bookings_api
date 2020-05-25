require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject { FactoryBot.build(:booking) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:vehicle) }

  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:duration) }
end
