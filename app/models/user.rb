class User < ApplicationRecord
  serialize :artworks_history, Array, coder: YAML

  after_initialize :set_default_artworks_history, if: :new_record?
  private

  def set_default_artworks_history
    self.artworks_history ||= []
  end
  validates :username, presence: { message: "cannot be null" }, uniqueness: { message: "username has been used" }
  validates :email, presence: { message: "cannot be null" }, uniqueness: { message: "email has been used" }

  has_secure_password

  has_one_attached :profile_picture
end
