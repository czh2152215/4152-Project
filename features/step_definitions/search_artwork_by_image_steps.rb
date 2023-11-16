Given("an artwork with ID {string} is pre-selected for search results") do |id|
  FactoryBot.create(:artwork, id: id)
end

Given("I am on the Image Upload page") do
  visit upload_path
end

# Additional step for file upload
When("I upload an image file") do
  file_path = Rails.root.join('features', 'support', 'fixtures', 'test.jpg')
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
  # Attach the file to the file input field
  attach_file('file', Rails.root.join('features', 'support', 'fixtures', 'no_match_image.jpeg'))

  # Click the 'Upload' button to submit the form
  click_button 'Upload'

end

# Check redirection to artwork page
Then("I should be redirected to the matched artwork page") do
  expect(current_path).to match(/\/artworks\/\d+/)
  artwork_id = current_path.match(/\/artworks\/(\d+)/)[1]
  # 假设有一个模型方法 Artwork.find_by_id 可以获取艺术品信息
  artwork = Artwork.find_by_id(artwork_id)
  expect(page).to have_content(artwork.title)
  # 检查页面上是否有代表艺术品的图片
  expect(page).to have_selector("img[src*='#{artwork.image_path}']")
end

# Use existing "Then I should see" step for checking alert messages
