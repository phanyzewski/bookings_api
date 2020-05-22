FactoryBot.define do
  factory :booking do
    start_time { "2020-05-22 15:42:24" }
    duration { 1 }
    details { "MyText" }
    account { nil }
    vehicle { nil }
  end
end
