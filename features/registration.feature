Feature: User Registration
  As a visitor
  I want to register an account
  So that I can use the application

  Scenario: Successful registration
    Given I am on the registration page
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "Sign Up"
    Then I should be redirected to the homepage
    And I should see "Registration successful!"

