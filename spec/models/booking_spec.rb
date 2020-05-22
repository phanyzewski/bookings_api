require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject { FactoryBot.build(:booking) }

  it { should belong_to(:account) }
  it { should belong_to(:vehicle) }

  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:duration) }
end
