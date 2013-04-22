Feature: Make a Tshirt
  In order to put a tshirt into production
  A user
  Should be able to make a new tshirt

  Scenario: A signed-out user makes a new tshirt
    Given I am not a signed-in user
    When I visit the new tshirt page
    Then I am redirected to the sign-in page

  Scenario: A singed-in user makes a new tshirt
    Given I am a signed-in user
    When I visit the new tshirt page
    And I enter a tshirt title of "Awesome Shirt"
    And I enter a tshirt description of "The most awesome shirt ever"
    And I click "Create My Tee"
    Then I should be on the preview page for the "Awesome Shirt" tshirt
