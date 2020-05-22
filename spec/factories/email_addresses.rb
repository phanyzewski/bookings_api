FactoryBot.define do
  factory :email_address do
    email { "MyString" }
    primary { "" }
    identity { nil }
  end
end
