FactoryBot.define do
  factory :identity do
    first_name { "MyString" }
    last_name { "MyString" }
    account { nil }
  end
end
