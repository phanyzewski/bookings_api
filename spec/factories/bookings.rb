FactoryBot.define do
  factory :booking do
    association :account, strategy: :create

    start_time { Time.current }
    duration { 1.hour }
    details { "MyText" }
    work_order {
      '{"job_id":"1","duration":"2","work":[{"diag":"1","oil change":"0.5","rotation":"0.5"}]}'
    }
  end
end
