Feature: Read scholarship iterations
  In order to describe scholarship iterations
  A guest
  Wants to try to add an scholarship iteration
  
  Scenario: Register new scholarship iteration
    Given a scholarship program named "scholarship program 1"
    And I am on the new scholarship iteration page
    Then I should see "Access denied"

  Scenario: Edit scholarship iteration
    Given a scholarship iteration named "scholarship iteration 1"
    When I go to the edit scholarship iteration page
    Then I should see "Access denied"

  @javascript
  Scenario: Delete scholarship iterations
    Given a scholarship iteration named "scholarship iteration 1"
    When I am on the scholarship iteration page
    Then I should not see "Actions"
