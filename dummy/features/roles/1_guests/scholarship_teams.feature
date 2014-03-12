Feature: Read scholarship teams
  In order to describe scholarship teams
  A guest
  Wants to try to add an scholarship team
  
  Scenario: Register new scholarship team
    Given I am on the new scholarship team page
    Then I should see "Access denied"

  Scenario: Edit scholarship team
    Given a scholarship team named "scholarship team 1"
    When I go to the edit scholarship team page
    Then I should see "Access denied"

  @javascript
  Scenario: Delete scholarship teams
    Given a scholarship team named "scholarship team 1"
    When I am on the scholarship team page
    Then I should not see "Actions"
