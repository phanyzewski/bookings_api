FactoryBot.define do
  factory :account do
    association :identity, strategy: :create
    association :vehicle, strategy: :create
  end
end
