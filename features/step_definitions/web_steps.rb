Given('I am on the login page') do
  visit login_path # Adjust the path as necessary
end

Given('a user with username {string} and password {string} exists') do |username, password|
  @user = FactoryBot.create(:user, username: username, email: "#{username}@example.com", password: password)
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Given(/^I am on the registration page$/) do
  visit register_path # This corresponds to your custom route for registration
end

Then('I should be redirected to the homepage') do
  expect(current_path).to eq root_path
end
