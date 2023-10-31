class Artwork < ApplicationRecord
  validates :uid, presence: true
  validates :artwork_name, presence: true
end
