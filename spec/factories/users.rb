FactoryBot.define do
  factory :user do
    email { "user@email.com" }
    password { "password"}
    password_confirmation { "password" }
    balance { 100 }
  end
end
