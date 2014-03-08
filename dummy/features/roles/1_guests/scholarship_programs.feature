Feature: Read scholarship programs
  In order to describe scholarship programs
  A guest
  Wants to try to add an scholarship program
  
  Scenario: Register new scholarship program
    Given I am on the new scholarship program page
    Then I should see "Access denied"

  Scenario: Edit scholarship program
    Given a scholarship program named "scholarship program 1"
    When I go to the edit scholarship program page
    Then I should see "Access denied"

  @javascript
  Scenario: Delete scholarship programs
    Given a scholarship program named "scholarship program 1"
    When I am on the scholarship program page
    Then I should not see "Actions"
