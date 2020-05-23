FactoryBot.define do
  factory :vehicle do
    association :account, strategy: :create
    vin { Faker::Vehicle.vin }
    year { Faker::Number.between(from: 1884, to: Time.zone.today.year) }
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model }
    color { Faker::Vehicle.color }
  end
end
