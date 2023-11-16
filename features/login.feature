Feature: User Login
  As a user,
  I want to log in and out of my account,
  So that I can access personalized features and end my session securely

  Background: 
    Given a user with username "user1" and password "password" exists

  Scenario: Successful login with username
    Given I am on the login page
    When I fill in "Username or Email" with "user1"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should be redirected to the "Main" page
    And I should see "Welcome, user1"

  Scenario: Successful login with email
    Given I am on the login page
    When I fill in "Username" with "user1@example.com"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should be redirected to the "Main" page
    And I should see "Welcome, user1"

  Scenario: Unsuccessful login with incorrect username
    Given I am on the login page
    When I fill in "Username" with "wronguser"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should see "Invalid username/email and password combination, please try again"

  Scenario: Unsuccessful login with incorrect email
    Given I am on the login page
    When I fill in "Username" with "wrongemail@example.com"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should see "Invalid username/email and password combination, please try again"

  Scenario: Unsuccessful login with incorrect password
    Given I am on the login page
    When I fill in "Username" with "user1"
    And I fill in "Password" with "wrongpassword"
    And I press "Log In"
    Then I should see "Invalid username/email and password combination, please try again"

  Scenario: Unsuccessful login with empty password
    Given I am on the login page
    When I fill in "Username" with "user1"
    And I fill in "Password" with ""
    And I press "Log In"
    Then I should see "Invalid username/email and password combination, please try again"

  Scenario: Unsuccessful login with empty username or email
    Given I am on the login page
    When I fill in "Username" with ""
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should see "Invalid username/email and password combination, please try again"

  Scenario: Successfully logging out
    Given I am a logged-in user
    When I press "Logout"
    Then I should be logged out
    And I should be redirected to the "homepage" page

  Scenario: Successfully logging out
    Given I am a logged-in user
    When I press "Log Out"
    Then I should be logged out
    And I should be redirected to the "homepage" page