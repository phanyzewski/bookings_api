require 'rails_helper'

RSpec.describe Telephone, type: :model do
  subject { FactoryBot.create(:telephone) }

  it { is_expected.to belong_to(:identity) }

  it { is_expected.to validate_presence_of(:phone_number) }
end
