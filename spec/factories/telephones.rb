FactoryBot.define do
  factory :telephone do
    phone_number { "MyString" }
    type { "" }
    preferred { "" }
    allow_sms { "" }
    identity { nil }
  end
end
