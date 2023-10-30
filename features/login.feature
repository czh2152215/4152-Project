Feature: User Login
  As a user
  I want to log in to my account
  So that I can access personalized features

  Background: 
    Given a user with username "user1" and password "password" exists

  Scenario: Successful login with username
    Given I am on the login page
    When I fill in "Username" with "user1"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should see "Welcome, user1"

  Scenario: Unsuccessful login with incorrect credentials
    Given I am on the login page
    When I fill in "Username" with "user1"
    And I fill in "Password" with "wrongpassword"
    And I press "Log In"
    Then I should see "Invalid username/email and password combination"
