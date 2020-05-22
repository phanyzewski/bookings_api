require 'rails_helper'

RSpec.describe Telephone, type: :model do
  subject { FactoryBot.build(:telephone) }
  it { should belong_to(:identity) }

  it { is_expected.to validate_presence_of(:phone_number) }
end
