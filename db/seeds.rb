# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# don't need to manually hash, has_secure_password will auto hash
# password1 = BCrypt::Password.create('admin')
require 'csv'

# Create users with usernames, emails, and hashed passwords
User.create(username: 'admin', email: 'admin@admin.com', password: 'admin')

# Create artworks with artwork_name, background_information, author, and image_url
CSV.foreach('db/van_gogh_paintings.csv', headers: true) do |row|
  Artwork.create(
    uid: row['ID'],
    artwork_name: row['Title'],
    author: row['Artist'],
    year: row['Year'],
    background_information: row['Description'],
    image_url: row['Image URL']
  )
  puts row['ID']
end

puts 'Database seed successfully!'
