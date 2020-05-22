FactoryBot.define do
  factory :vehicle do
    vin { Faker::Vehicle.vin }
    year { Faker::Number.between(from: 1884, to: Time.zone.today.year) }
    account { nil }
  end
end
