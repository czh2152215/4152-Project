Feature: User Registration
  As a visitor
  I want to register an account
  So that I can use the application

  Scenario: Successful registration
    Given I am on the registration page
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "Register"
    Then I should be redirected to the homepage
    And I should see "Registration successful!"

  Scenario: Registration with already used email
    Given I am on the registration page
    When I fill in "Email" with "existinguser@example.com"
    And I fill in "Password" with "somepassword"
    And I press "Register"
    Then I should see "Email has already been taken"
