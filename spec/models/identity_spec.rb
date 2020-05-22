require 'rails_helper'

RSpec.describe Identity, type: :model do
  subject { FactoryBot.create(:identity) }

  it { should belong_to(:account) }

  it { should have_many(:email_addresses) }
  it { should have_many(:telephones) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end
