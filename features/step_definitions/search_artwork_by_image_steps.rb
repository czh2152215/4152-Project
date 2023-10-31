Given("an artwork with ID {string} is pre-selected for search results") do |id|
  FactoryBot.create(:artwork, id: id)
end

Given("I am on the Image Upload page") do
  visit upload_path
end

# Additional step for file upload
When("I upload an image file") do
  file_path = Rails.root.join('features', 'support', 'fixtures', 'starry_night.jpeg')
  attach_file('file', file_path) # Assuming the file input field is named 'file'
  click_button 'Upload'
end

When("I press the {string} button without selecting a file") do |button_name|
  click_button button_name
end

Then("I should be redirected to the home page with an alert {string}") do |message|
  expect(current_path).to eq root_path
  expect(page).to have_content(message)
end

When("I upload an image file for which there is no matching artwork") do
  # Navigate to the image upload page with the parameter to simulate no match
  visit upload_path

  # Attach the file to the file input field
  attach_file('file', Rails.root.join('features', 'support', 'fixtures', 'no_match_image.jpeg'))

  # Click the 'Upload' button to submit the form
  click_button 'Upload'

end

# Check redirection to artwork page
Then("I should be redirected to the artwork page for the pre-selected artwork") do
  expect(current_path).to eq artwork_path(1)
end

# Use existing "Then I should see" step for checking alert messages
