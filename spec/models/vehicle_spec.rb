require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  subject { FactoryBot.build(:vehicle) }
  it { should belong_to(:account) }

  it { is_expected.to validate_presence_of(:vin) }
  it { is_expected.to validate_presence_of(:year) }
end
