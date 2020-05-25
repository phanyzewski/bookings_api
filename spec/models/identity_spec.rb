require 'rails_helper'

RSpec.describe Identity, type: :model do
  subject { FactoryBot.create(:identity) }

  it { is_expected.to belong_to(:account) }

  it { is_expected.to have_many(:email_addresses) }
  it { is_expected.to have_many(:telephones) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end
