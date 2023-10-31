Given('I am on the login page') do
  visit login_path # Adjust the path as necessary
end

Given('a user with username {string} and password {string} exists') do |username, password|
  @user = FactoryBot.create(:user, username: username, email: "#{username}@example.com", password: password)
end

Given('there is a user registered with username {string} and email {string}') do |username, email|
  User.create!(username: username, email: email, password: 'a_secure_password')
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I press {string}') do |name|
  click_on name
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Given(/^I am on the registration page$/) do
  visit register_path # This corresponds to your custom route for registration
end

Then('I should be redirected to the {string} page') do |page_name|
  path = case page_name
         when "homepage"
           root_path
         when "user's profile"
           user = User.find_by(id: @user.id)
           raise "No user found with id" unless user
           user_path(user)
         when "registration"
          register_path
         else
           raise "Path for #{page_name} is not defined in step definitions"
         end

  expect(current_path).to eq path
end

Given('I am a logged-in user') do
  @user = User.find_by(username: "user1") || User.create(username: "user1", email: "user1@example.com", password: "password")
  
  visit login_path
  step 'I fill in "Username" with "user1"'
  step 'I fill in "Password" with "password"'
  click_button 'Log In'

  # Verify that we are on the user's profile page
  expect(page).to have_current_path(user_path(@user))
  expect(page).to have_content("Welcome, #{@user.username}")

end

Then('I should be logged out') do
  expect(page).not_to have_content('Welcome, user1')
end

When('I go to the edit user page') do
  visit user_path(@user)
  click_link 'Edit my account'
end
