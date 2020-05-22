FactoryBot.define do
  factory :email_address do
    association :identity, strategy: :create
    email { Faker::Internet.email }
    preferred { "" }
  end
end
