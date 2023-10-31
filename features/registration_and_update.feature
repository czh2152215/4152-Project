Feature: User Registration and Update
  As a visitor
  I want to register an account and update my information
  So that I can use the application with my details

  Scenario: Successful registration
    Given I am on the registration page
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "Sign Up"
    Then I should be redirected to the "homepage" page
    And I should see "Registration successful!"

  Scenario: Attempt to register with a repeated username
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with "existinguser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "Sign Up"
    Then I should see "username has been used"
    And I should be redirected to the "registration" page

  Scenario: Attempt to register with a repeated email
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "existinguser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "Sign Up"
    Then I should see "email has been used"
    And I should be redirected to the "registration" page

  Scenario: Updating user information successfully
    Given I am a logged-in user
    When I go to the edit user page
    And I fill in "username" with "updateduser"
    And I press "update"
    Then I should be redirected to the "user's profile" page
    And I should see "User Info Updated"

  Scenario: Unsuccessful information update due to empty username
    Given I am a logged-in user
    When I go to the edit user page
    And I fill in "username" with ""
    And I press "update"
    Then I should see "Username cannot be null" 

  Scenario: Unsuccessful information update due to empty email
    Given I am a logged-in user
    When I go to the edit user page
    And I fill in "email" with ""
    And I press "update"
    Then I should see "Email cannot be null" 