Given("the following artworks exist:") do |table|
  table.hashes.each do |row|
    Artwork.create!(
      artwork_name: row['artwork_name'],
      author: row['author'],
      background_information: row['background_information']
    )
  end
end

When("I visit the artwork page for {string}") do |artwork_name|
  artwork = Artwork.find_by(artwork_name: artwork_name)
  visit artwork_path(artwork)
end

# Use existing "Then I should see" step for checking artwork details

When("I visit the artwork page with an invalid ID") do
  visit "/artworks/invalid_id"
end

Then("I should see details about {string}") do |artwork_name|
  expect(page).to have_content(artwork_name)

  # Assuming the details include the author and some background information
  artwork = Artwork.find_by(artwork_name: artwork_name)
  expect(page).to have_content(artwork.author)
  expect(page).to have_content(artwork.background_information)
end

# Use existing "Then I should be redirected to the homepage" step for redirection checks
# Use existing "Then I should see" step for checking alert messages
