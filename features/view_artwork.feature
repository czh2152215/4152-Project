Feature: View Artwork Details
  As a visitor
  I want to view details of an artwork
  So that I can learn more about it

  Background: Artworks exist in the system
    Given the following artworks exist:
      | artwork_name    | author          | background_information                           |
      | The Starry Night | Vincent van Gogh | A famous painting by Vincent van Gogh. |

  Scenario: Successfully viewing an artwork
    When I visit the artwork page for "The Starry Night"
    Then I should see details about "The Starry Night"

  Scenario: Unsuccessfully viewing an artwork with invalid ID
    When I visit the artwork page with an invalid ID
    Then I should be redirected to the home page with an alert "No artwork found with that artwork ID."

  Scenario: Successfully Favorite an artwork
    Given I am a logged-in user
    When I visit the artwork page for "The Starry Night"
    Then I should see "Favorite"
    When I press "Favorite"
    Then I should see "Unfavorite"
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    Then I should see "The Starry Night"
    When I press "The Starry Night"
    Then I should see details about "The Starry Night"

  Scenario: Successfully Favorite an artwork
    Given I am a logged-in user
    When I visit the artwork page for "The Starry Night"
    Then I should see "Favorite"
    When I press "Favorite"
    Then I should see "Unfavorite"
    Then I press "Unfavorite"
    Then I should see "Favorite"
    When I press "My Profile"
    Then I should be redirected to the "user's profile" page
    Then I should not see "The Starry Night"