FactoryBot.define do
  factory :user do
    nickname { "test_user" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end