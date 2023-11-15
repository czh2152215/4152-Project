Feature: User Profile and User information Update
  As a user
  I want to check and update my profile info

  Scenario: Updating user information successfully
    Given I am a logged-in user
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    When I go to the edit user page
    And I fill in "username" with "updateduser"
    And I press "update"
    Then I should be redirected to the "user's profile" page
    And I should see "User Info Updated"

  Scenario: Unsuccessful information update due to empty username
    Given I am a logged-in user
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    When I go to the edit user page
    And I fill in "username" with ""
    And I press "update"
    Then I should see "Username cannot be null"

  Scenario: Direct to profile page
    Given I am a logged-in user
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    And I should see "No profile picture uploaded"
    And I should see "Username:"
    And I should see "Email:"
    And I should see "Artwork History"

  Scenario: Update username
    Given I am a logged-in user
    When I go to the edit user page
    And I fill in "username" with "updateduser"
    And I press "update"
    Then I should be redirected to the "user's profile" page
    And I should see "User Info Updated"
    And I should see "updateduser"

  Scenario: Update email
    Given I am a logged-in user
    When I go to the edit user page
    And I fill in "email" with "updateduser@example.com"
    And I press "update"
    Then I should be redirected to the "user's profile" page
    And I should see "User Info Updated"
    And I should see "updateduser@example.com"

  Scenario: Update password
    Given I am a logged-in user
    When I go to the edit user page
    And I fill in "password" with "newpassword"
    And I press "update"
    Then I should be redirected to the "user's profile" page
    When I press "Log Out"
    Then I should be logged out
    And I should be redirected to the "homepage" page
    When I press "Login"
    Then I should be redirected to the "login" page
    Then I fill in "Username or Email" with "user1"
    And I fill in "Password" with "newpassword"
    And I press "Log In"
    Then I should be redirected to the "Main" page
    And I should see "Welcome, user1"

  Scenario: No profile-picture with new user
    Given I am a logged-in user
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    And I should see "No profile picture uploaded."

  Scenario: Upload new profile-picture
    Given I am a logged-in user
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    When I press "Edit my account"
    Then I should be redirected to the "edit profile" page
    When I attach the file "features/support/fixtures/starry_night.jpeg" to "Profile picture"
    And I press "update"
    Then I should be redirected to the "user's profile" page
    And I should see "User Info Updated"
    Then I should see my profile picture displayed on my profile