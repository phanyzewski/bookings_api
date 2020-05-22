FactoryBot.define do
  factory :telephone do
    association :identity, strategy: :create
    phone_number { Faker::PhoneNumber.phone_number }
    phone_type { 'mobile' }
    preferred { "" }
    allow_sms { "" }
  end
end
