Feature: Search Artwork By Image
  As a visitor
  I want to upload an image to search for a related artwork
  So that I can find information about the artwork in the image

  Background: A pre-stored artwork is used for search results
    Given an artwork with ID "1" is pre-selected for search results

  Scenario: Successfully finding an artwork from an uploaded image
    Given I am on the Image Upload page
    When I upload an image file
    Then I should be redirected to the artwork page for the pre-selected artwork

  Scenario: Unsuccessfully finding an artwork due to no image uploaded
    Given I am on the Image Upload page
    When I press the "Upload" button without selecting a file
    Then I should be redirected to the home page with an alert "No file uploaded."

  Scenario: Unsuccessfully finding an artwork due to no matching artwork
    Given I am on the Image Upload page
    When I upload an image file for which there is no matching artwork
    Then I should be redirected to the home page with an alert "No artwork found for the uploaded image."
