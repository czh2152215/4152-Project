class Artwork < ApplicationRecord
  validates :artwork_name, presence: true

  has_many :favorites
end
