class User < ApplicationRecord
  validates :username, presence: { message: "username cannot be null" }, uniqueness: { message: "username has been used" }
  validates :email, presence: { message: "email cannot be null" }, uniqueness: { message: "email has been used" }

  has_secure_password
end
