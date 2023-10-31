class Artwork < ApplicationRecord
  validates :artwork_name, presence: true
end
