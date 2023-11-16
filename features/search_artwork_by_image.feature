Feature: Search Artwork By Image
  As a visitor
  I want to upload an image to search for a related artwork
  So that I can find information about the artwork in the image

  Background: A pre-stored artwork is used for search results
    Given an artwork with ID "1" is pre-selected for search results

  Scenario: Successfully finding an artwork from an uploaded image
    Given I am a logged-in user
    When I press "Upload Photo"
    Then I upload an image file
#    Then I should be redirected to the matched artwork page

  Scenario: Unsuccessfully finding an artwork due to no image uploaded
    Given I am a logged-in user
    When I press "Upload Photo"
    Then I press "Upload"
    Then I should see "No file uploaded."

  Scenario: Unsuccessfully finding an artwork due to no matching artwork
    Given I am a logged-in user
    When I press "Upload Photo"
    When I upload an image file for which there is no matching artwork
    Then I should see "No artwork found for the uploaded image. Try another one."

  Scenario:  Cannot upload when log out
    Given I am on the login page
    When I press "Upload Photo"
    Then I should see "You must be logged in to access this page."