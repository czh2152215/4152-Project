# spec/factories/user.rb
FactoryBot.define do
  factory :user do
    username { "user1" }
    email { "user1@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
