FactoryBot.define do
  factory :identity do
    association :account, strategy: :create

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
