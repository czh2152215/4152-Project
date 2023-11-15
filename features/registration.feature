Feature: User Registration and Update
  As a visitor
  I want to register an account and update my information
  So that I can use the application with my details

  Scenario: Successful registration
    Given I am on the registration page
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "sub-sign-up"
    Then I should be redirected to the "homepage" page
    And I should see "Registration Successful!"

  Scenario: Attempt to register with a repeated username
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with "existinguser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "sub-sign-up"
    Then I should see "username has been used"
    And I should be redirected to the "registration" page

  Scenario: Attempt to register with a repeated email
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "existinguser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "sub-sign-up"
    Then I should see "email has been used"
    And I should be redirected to the "registration" page

  Scenario: Attempt to register with a invalid email
    Given I am on the registration page
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "newuser"
    And I fill in "Password" with "newpassword"
    And I press "sub-sign-up"
    Then I should see "Sign Up"

  Scenario: Attempt to register with a empty username
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with ""
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "newpassword"
    And I press "sub-sign-up"
    Then I should see "Username cannot be null"
    And I should be redirected to the "registration" page

  Scenario: Attempt to register with a empty email
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with "newuser"
    And I fill in "Email" with ""
    And I fill in "Password" with "newpassword"
    And I press "sub-sign-up"
    Then I should see "Email cannot be null"
    And I should be redirected to the "registration" page

  Scenario: Attempt to register with a empty password
    Given I am on the registration page
    And there is a user registered with username "existinguser" and email "existinguser@example.com"
    When I fill in "Username" with "newuser"
    And I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with ""
    And I press "sub-sign-up"
    Then I should see "Password can't be blank"
    And I should be redirected to the "registration" page


