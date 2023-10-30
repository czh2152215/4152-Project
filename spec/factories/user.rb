# spec/factories/user.rb
FactoryBot.define do
  factory :user do
    username { "user1" }
    email { "user1@example.com" }
    password { "password" }
    # Add any other required fields for your User model here.
  end
end
