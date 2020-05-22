FactoryBot.define do
  factory :booking do
    association :account, strategy: :create

    start_time { Time.current }
    duration { 1.hour }
    details { "MyText" }
  end
end
