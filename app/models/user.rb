class User < ApplicationRecord
  serialize :artworks_history, Array, coder: YAML

  after_initialize :set_default_artworks_history, if: :new_record?

  def add_to_favorites(artwork)
    favorited_artworks << artwork unless favorited_artworks.include?(artwork)
  end

  def remove_from_favorites(artwork)
    favorited_artworks.delete(artwork)
  end

  private

  def set_default_artworks_history
    self.artworks_history ||= []
  end
  validates :username, presence: { message: "cannot be null" }, uniqueness: { message: "username has been used" }
  validates :email, presence: { message: "cannot be null" }, uniqueness: { message: "email has been used" }

  has_secure_password

  has_one_attached :profile_picture

  # 添加与收藏的关联
  has_many :favorites
  has_many :favorited_artworks, through: :favorites, source: :artwork

end
