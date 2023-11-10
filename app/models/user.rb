class User < ApplicationRecord
  validates :username, presence: { message: "cannot be null" }, uniqueness: { message: "username has been used" }
  validates :email, presence: { message: "cannot be null" }, uniqueness: { message: "email has been used" }

  has_secure_password

  has_one_attached :profile_picture
end
